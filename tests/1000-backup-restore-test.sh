#!/usr/bin/env sh

describe "The backup/restore container"

it_has_a_health_check() {
    curl -s --fail http://postgres-s3:8000/status/health
}
