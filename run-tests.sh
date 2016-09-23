#!/usr/bin/env bash

set -e
set -u

tearDown() {
	docker-compose down
}

trap tearDown EXIT

docker-compose build 
docker-compose run --rm tests
