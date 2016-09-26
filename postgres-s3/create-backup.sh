#!/usr/bin/env sh
set -e
set -u

source variables.sh

echo "Starting backup"
PGPASSWORD=${POSTGRES_PASSWORD} pg_dump -Fc -h database -U ${DB_USER} ${DB_NAME} > /data/${FILENAME}

echo "Backup complete, starting transfer"
aws --endpoint-url="${S3_ENDPOINT}" --region="${S3_REGION}" s3 cp "/data/${FILENAME}" "${S3_FILENAME}"

echo "Transfer complete"
