#!/usr/bin/env sh

source_sql() {
    psql -h source-db -p 5432 -U ${SOURCE_USER} -d ${SOURCE_DB} -t -c "$1"
}

target_sql() {
    psql -h target-db -p 5432 -U ${TARGET_USER} -d ${TARGET_DB} -t -c "$1"
}

run_aws() {
    export AWS_ACCESS_KEY_ID=1234
    export AWS_SECRET_ACCESS_KEY=asdf
    aws --endpoint-url="http://fake-s3:4569" --region=eu-central-1 $*
}
