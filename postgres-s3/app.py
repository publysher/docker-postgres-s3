import http.server
import logging
import socketserver
import subprocess

import os


log = logging.getLogger(__name__)

BASE_DIR = os.path.dirname(os.path.abspath(__file__))
DISPATCHERS = {
    '/status/health/': {
        'GET': os.path.join(BASE_DIR, 'check-health.sh'),
    },
    '/backup/': {
        'POST': os.path.join(BASE_DIR, 'create-backup.sh'),
    }
}


class HttpHandler(http.server.BaseHTTPRequestHandler):

    def do_any(self):
        if self.path[-1] != '/':
            self.path += '/'

        path_dispatcher = DISPATCHERS.get(self.path)
        if not path_dispatcher:
            return self.send_message(404, "404 Not Found")

        script = path_dispatcher.get(self.command)
        if not script:
            return self.send_message(405, "405 Method Not Allowed")

        # noinspection PyBroadException
        try:
            log.info("%s %s -> %s", self.command, self.path, script)
            result = subprocess.run(script,
                                    stdout=subprocess.PIPE,
                                    stderr=subprocess.PIPE,
                                    universal_newlines=True)

            log.debug('Execution complete, result code is %d', result.returncode)
            if result.stdout:
                log.debug("stdout:\n%s", result.stdout)

            if result.stderr:
                log.debug("stderr:\n%s", result.stderr)

            if result.returncode == 0:
                return self.send_message(200, result.stdout)

            return self.send_message(500, result.stderr)

        except Exception as e:
            log.exception("Could not execute command")
            return self.send_message(500, "500 Internal Server Error")

    def do_POST(self):
        return self.do_any()

    def do_GET(self):
        return self.do_any()

    def send_message(self, status_code, content, mime_type="text/plain", encoding="utf-8"):
        content = content or ""
        content += "\n"
        self.send_response(status_code)
        self.send_header("Content-Type", "{}; charset={}".format(mime_type, encoding))
        self.send_header("Content-Length", len(content))
        self.end_headers()
        self.wfile.write(content.encode(encoding))


if __name__ == "__main__":
    logging.basicConfig(
        level=logging.DEBUG,
    )

    socketserver.TCPServer.allow_reuse_address = True
    httpd = socketserver.TCPServer(("", 8000), HttpHandler)

    log.info("Running daemon on 0.0.0.0:8000")

    try:
        httpd.serve_forever()
    except KeyboardInterrupt:
        pass
    log.info("Shutting down server")
    httpd.server_close()
