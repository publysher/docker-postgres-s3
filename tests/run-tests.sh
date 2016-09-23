#!/usr/bin/env sh

set -e
set -u

echo "source-db:5432:${SOURCE_DB}:${SOURCE_USER}:${SOURCE_PASSWORD}" > ~/.pgpass
echo "target-db:5432:${TARGET_DB}:${TARGET_USER}:${TARGET_PASSWORD}" >> ~/.pgpass
chmod 0600 ~/.pgpass

sleep 10

exec /usr/local/bin/roundup
