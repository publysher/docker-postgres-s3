# docker-postgres-s3

A Docker-based solution for Postgres backups/restores on Amazon S3.

## Goals

This project solves the following problems:

* I need a Postgres backup/restore solution which uses S3
* I want this solution to run in a container
* I want this container to be separate from the actual Postgres database
* I want to trigger the backups by HTTP, so I can use any scheduling mechanism I want
* I want to easily trigger restores as part of my development cycle

## Environment variables

| Name | Required | Description |
| --- | --- | --- |
| `POSTGRES_DB` | No, defaults to `postgres` | Name of the Postgres database to back-up from/restore into. |
| `POSTGRES_USER` | No, defaults to the value of `POSTGRES_DB` | Name of the Postgres user to connect as. |
| `POSTGRES_PASSWORD` | Yes | Password to use when connecting to the database. |
| `S3_ENDPOINT` | Yes | S3 endpoint to use when connecting. See http://docs.aws.amazon.com/general/latest/gr/rande.html#s3_region for a list of valid endpoints. |
| `S3_BUCKET` | Yes | Name of the S3 bucket to store the database dump | 
| `S3_FILE` | No | Name of the S3 file. Defaults to `${POSTGRES_DB}.pgdump` |
| `AWS_ACCESS_KEY_ID` | Yes | AWS Access key. For uploads, requires write permissions on the bucket. |
| `AWS_SECRET_ACCESS_KEY` | Yes | AWS Secret key. | 
| `PG_RESTORE_ARGS` | No | Extra arguments to pass to `pg_restore`. | 
| ---| --- | --- |


## Testing

Use `docker-compose build && docker-compose run --rm tests` to run the integration tests. 


