FROM alpine:latest

WORKDIR /app/
ENV ROUNDUP_VERSION v0.0.5

RUN apk update \
    && apk add \
        'curl' \
        'ncurses' \
        'postgresql-client<9.6' \
        'py-pip' \
    && apk add --virtual buildDeps \
        'make' \
    && curl -L https://github.com/bmizerany/roundup/tarball/${ROUNDUP_VERSION} | tar xvzf - \
    && cd bmizerany-roundup-*  && ./configure && make && make install && cd .. \
    && rm -r bmizerany-roundup-* \
    && apk del buildDeps \
    && rm -rf /var/cache/apk/* \
    && pip install awscli

COPY *.sh /app/

CMD ["/app/run-tests.sh"]

