#!/usr/bin/env sh
source utilities.sh

describe "The backup/restore container"

before() {
    # create bucket
    run_aws s3 mb "s3://backup.bucket"
}

it_has_a_health_check() {
    curl -s --fail http://postgres-s3:8000/status/health
}

it_creates_a_backup_after_a_specific_post() {
    # run backup
    curl -s --fail -X POST http://postgres-s3:8000/backup

    # check that source.dump has been created
    curl -s http://fake-s3:4569 | grep "source.pgdump"
}

it_can_restore_a_backup() {
    # create some data
    source_sql "DROP TABLE IF EXISTS test_restore"
    source_sql "CREATE TABLE IF NOT EXISTS test_restore ( name VARCHAR(20) PRIMARY KEY )"
    source_sql "INSERT INTO test_restore (name) VALUES ('postgres-s3')"
    test $(source_sql "SELECT COUNT(*) FROM test_restore") = "1"

    # run backup
    curl -s --fail -X POST http://postgres-s3:8000/backup

    # remove data
    source_sql "DROP TABLE test_restore"

    # run restore
    curl -s --fail -X POST http://postgres-s3:8000/restore

    # data should be back!
    test $(source_sql "SELECT COUNT(*) FROM test_restore") = "1"
}

it_can_restore_a_backup_to_a_different_server() {
    # create some data
    source_sql "DROP TABLE IF EXISTS test_restore"
    source_sql "CREATE TABLE IF NOT EXISTS test_restore ( name VARCHAR(20) PRIMARY KEY )"
    source_sql "INSERT INTO test_restore (name) VALUES ('postgres-s3')"
    test $(source_sql "SELECT COUNT(*) FROM test_restore") = "1"

    # ensure absence on target
    target_sql "DROP TABLE IF EXISTS test_restore"

    # run backup
    curl -s --fail -X POST http://postgres-s3:8000/backup

    # restore on different machine
    curl -s --fail -X POST http://postgres-s3-target:8000/restore

    # data should now be present on target
    test $(target_sql "SELECT COUNT(*) FROM test_restore") = "1"
}
