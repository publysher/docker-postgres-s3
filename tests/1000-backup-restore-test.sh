#!/usr/bin/env sh

describe "The backup/restore container"

it_has_a_health_check() {
    curl -s --fail http://postgres-s3:8000/status/health
}

it_creates_a_backup_after_a_specific_post() {
    curl -s --fail -X POST http://postgres-s3:8000/backup
}
