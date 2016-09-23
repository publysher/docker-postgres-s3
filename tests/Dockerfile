FROM alpine:latest

RUN apk add --update 'postgresql-client<9.6'  \
    && rm -rf /var/cache/apk

ADD *.sh /app/

CMD ["/app/run-tests.sh"]

