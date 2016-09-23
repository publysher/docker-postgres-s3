FROM python:3.5-alpine
MAINTAINER "Yigal Duppen" <yigal@publysher.nl>

WORKDIR /app/
EXPOSE 8000
STOPSIGNAL SIGINT
HEALTHCHECK CMD ["/app/check-health.sh"]

RUN apk update \
    && apk add \
        'postgresql<9.6' \
    && rm -rf /var/cache/apk/* \
    && pip3 install awscli \
    && adduser -S service \
    && mkdir -p /app/ /data/  \
    && chown service /data/
USER service
COPY * /app/

ENTRYPOINT ["python", "app.py"]
