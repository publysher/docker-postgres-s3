FROM python:3.6-slim
MAINTAINER "Yigal Duppen" <yigal@publysher.nl>

SHELL ["/bin/bash", "-c"]

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

RUN apt-get update \
	  && apt-get install -yqq --no-install-recommends \
      wget \
      lsb-release \
      sudo \
      gnupg \
    && rm -rf /var/lib/apt/lists/*



# Install Postgresql11
# https://computingforgeeks.com/how-to-install-postgresql-11-on-debian-9-debian-8/
RUN export RELEASE=$(lsb_release -cs) \
		&& wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add - \
		&& echo "deb http://apt.postgresql.org/pub/repos/apt/ ${RELEASE}"-pgdg main | sudo tee  /etc/apt/sources.list.d/pgdg.list \
		&& sudo apt update && sudo apt -y install postgresql-11 \
    && rm -rf /var/lib/apt/lists/* \
    && pip3 install awscli \
    && adduser --system service \
    && mkdir -p /app/ /data/  \
    && chown service /data/
USER service
COPY * /app/

ENTRYPOINT ["python", "app.py"]
