[![Docker Automated build](https://img.shields.io/docker/automated/publysher/postgres-s3.svg)](https://hub.docker.com/r/publysher/automated-badger/) 
[![](https://images.microbadger.com/badges/image/publysher/postgres-s3.svg)](http://microbadger.com/images/publysher/automated-badger "Get your own image badge on microbadger.com")

# docker-postgres-s3

A Docker-based solution for Postgres backups/restores on Amazon S3.

## Goals

This project solves the following problems:

* I need a Postgres backup/restore solution which uses S3
* I want this solution to run in a container
* I want this container to be separate from the actual Postgres database
* I want to trigger the backups by HTTP, so I can use any scheduling mechanism I want
* I want to easily trigger restores as part of my development cycle

## Usage

Instantiate the image with a target postgres database and an existing S3 bucket. The container will have a service 
running on port 8000, with the following endpoints:
 
* `GET` http://service:8000/status/health/ - a simple health check
* `POST` http://service:8000/backup/ - create a new backup and copy this to S3
* `POST` http://service:8000/restore/ - obtain the backup from S3 and restore it into the target database


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


## Examples

The following examples are all shown as docker-compose files. 

### 100% Docker, minimal example

Here the target database is also managed by docker. 

```
version: "2"
services:
  db:
    image: postgres:9.5
    environment:
      POSTGRES_PASSWORD: password
      
  postgres-s3:
    image: publysher/postgres-s3
    links:
        - "db:database"     # target database should always be linked as `database`
    ports:
        - "8000:8000"       # you should not expose this to a public network
    environment:
      POSTGRES_PASSWORD: password
      S3_ENDPOINT: "https://s3.amazonaws.com"
      S3_BUCKET: "s3://my-bucket"
      AWS_ACCESS_KEY_ID: "access-key"
      AWS_SECRET_ACCESS_KEY: "secret"
```

### Using an external database

In this example, the external database is not managed by docker. We use the `extra_hosts` option to connect 
to the database.

```
version: "2"
services:
  postgres-s3:
    image: publysher/postgres-s3
    environment:
      POSTGRES_DB: my_database
      POSTGRES_USER: my_user
      POSTGRES_PASSWORD: password
      S3_ENDPOINT: "https://s3.amazonaws.com"
      S3_BUCKET: "s3://my-bucket"
      AWS_ACCESS_KEY_ID: "access-key"
      AWS_SECRET_ACCESS_KEY: "secret"
    extra_hosts:
        - "database":192.168.99.101
```


## Testing

Use `docker-compose build && docker-compose run --rm tests` to run the integration tests. 


