import http.server
import socketserver


# noinspection PyPep8Naming
class HealthHandler(http.server.BaseHTTPRequestHandler):
    def do_GET(self):
        self.send_message(200, "Healthy")

    def send_message(self, status_code, content, mime_type="text/plain", encoding="utf-8"):
        self.send_response(status_code)
        self.send_header("Content-Type", "{}; charset={}".format(mime_type, encoding))
        self.send_header("Content-Length", len(content))
        self.end_headers()
        self.wfile.write(content.encode(encoding))


if __name__ == "__main__":
    httpd = socketserver.TCPServer(("", 8000), HealthHandler)
    print("Serving 0.0.0.0:8000")
    httpd.serve_forever()
