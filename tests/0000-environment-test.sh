#!/usr/bin/env sh
source utilities.sh

describe "The basic test environment"

it_can_run_tests() {
    echo yes > /dev/null
}

it_can_connect_to_the_source_database() {
    source_sql "SELECT 42"
}

it_can_connect_to_the_target_database() {
    target_sql "SELECT 42"
}
