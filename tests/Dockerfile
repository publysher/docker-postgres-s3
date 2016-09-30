FROM publysher/roundup

RUN apk update \
    && apk add \
        'curl' \
        'postgresql-client<9.6' \
        'py-pip' \
    && rm -rf /var/cache/apk/* \
    && pip install awscli

COPY *.sh /tests/
COPY links.txt /tests/

