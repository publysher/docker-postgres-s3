# docker-postgres-s3

A Docker-based solution for Postgres backups/restores on Amazon S3.

## Goals

This project solves the following problems:

* I need a Postgres backup/restore solution which uses S3
* I want this solution to run in a container
* I want this container to be separate from the actual Postgres database
* I want to trigger the backups by HTTP, so I can use any scheduling mechanism I want
* I want to easily trigger restores as part of my development cycle

## Testing

Use `docker-compose build && docker-compose run --rm tests` to run the integration tests. 


