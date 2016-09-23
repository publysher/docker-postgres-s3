#!/usr/bin/env sh

source_sql() {
    psql -h source-db -p 5432 -U ${SOURCE_USER} -d ${SOURCE_DB} -c "$1"
}

target_sql() {
    psql -h target-db -p 5432 -U ${TARGET_USER} -d ${TARGET_DB} -c "$1"
}


