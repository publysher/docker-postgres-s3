#!/usr/bin/env sh

set -e
set -u

echo "source-db:5432:${SOURCE_DB}:${SOURCE_USER}:${SOURCE_PASSWORD}" > ~/.pgpass
echo "target-db:5432:${TARGET_DB}:${TARGET_USER}:${TARGET_PASSWORD}" >> ~/.pgpass
chmod 0600 ~/.pgpass

wait_for() {
    echo -n "Waiting for $3 "
    while ! nc -z $1 $2
    do
        echo -n "."
        sleep 0.25
    done
    echo "[OK]"
}

wait_for source-db 5432 "source database"
wait_for target-db 5432 "target database"
wait_for fake-s3 4569 "S3 provider"
wait_for postgres-s3 8000 "backup/restore service"
wait_for source-db 5432 "source database"       # run twice, because the postgres image does quite some restarting

exec /usr/local/bin/roundup
