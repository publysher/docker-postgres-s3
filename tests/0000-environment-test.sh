#!/usr/bin/env sh

describe "The basic test environment"

source_sql() {
    psql -h source-db -p 5432 -U ${SOURCE_USER} -d ${SOURCE_DB} -c $1
}

target_sql() {
    psql -h target-db -p 5432 -U ${TARGET_USER} -d ${TARGET_DB} -c $1
}

it_can_run_tests() {
    echo yes > /dev/null
}

it_can_ping_the_source_database() {
    nc -z source-db 5432
}

it_can_ping_the_target_database() {
    nc -z target-db 5432
}

it_can_ping_the_fake_s3_datasource() {
    nc -z fake-s3 4569
}

it_can_connect_to_the_source_database() {
    source_sql "SELECT 42"
}

it_can_connect_to_the_target_database() {
    target_sql "SELECT 42"
}
