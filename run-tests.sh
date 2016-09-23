#!/usr/bin/env bash

set -e
set -u

tearDown() {
	docker-compose down
}

trap tearDown EXIT

docker-compose build 
docker-compose run --rm tests || (docker-compose logs postgres-s3 ; docker-compose logs postgres-s3-target)

