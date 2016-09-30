#!/usr/bin/env sh
source utilities.sh

describe "The basic test environment"

before() {
    echo "source-db:5432:${SOURCE_DB}:${SOURCE_USER}:${SOURCE_PASSWORD}" > ~/.pgpass
    echo "target-db:5432:${TARGET_DB}:${TARGET_USER}:${TARGET_PASSWORD}" >> ~/.pgpass
    chmod 0600 ~/.pgpass
}

it_can_run_tests() {
    echo yes > /dev/null
}

it_can_connect_to_the_source_database() {
    source_sql "SELECT 42"
}

it_can_connect_to_the_target_database() {
    target_sql "SELECT 42"
}
