FROM python:3.6-alpine
MAINTAINER "Yigal Duppen" <yigal@publysher.nl>

WORKDIR /app/
EXPOSE 8000
STOPSIGNAL SIGINT
HEALTHCHECK CMD ["/app/check-health.sh"]

RUN adduser -S service
USER service
COPY * /app/

ENTRYPOINT ["python", "app.py"]
