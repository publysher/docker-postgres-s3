FROM python:3.5-alpine
MAINTAINER "Yigal Duppen" <yigal@publysher.nl>

WORKDIR /app/
EXPOSE 8000
STOPSIGNAL SIGINT
HEALTHCHECK CMD ["/app/check-health.sh"]

LABEL   org.label-schema.schema-version="1.0" \
        org.label-schema.name="Postgres/S3" \
        org.label-schema.description="A service to backup and restore postgres databases to S3" \
        org.label-schema.url="https://github.com/publysher/docker-postgres-s3/" \
        org.label-schema.vcs-url="https://github.com/publysher/docker-postgres-s3" \
        org.label-schema.vendor="Publysher BV" \
        org.label-schema.docker.dockerfile="./postgres-s3/Dockerfile"

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
