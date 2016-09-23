FROM python:3.6-alpine
MAINTAINER "Yigal Duppen" <yigal@publysher.nl>

WORKDIR /app/
EXPOSE 8000

RUN adduser -S service
USER service
ADD * /app/

CMD ["python", "app.py"]
