#!/usr/bin/env sh
#!/usr/bin/env sh
set -e
set -u

source variables.sh

echo "Transferring data from S3"
aws --endpoint-url="${S3_ENDPOINT}" s3 cp "${S3_FILENAME}" /data/${FILENAME}

echo "Transfer complete, starting restore"
PGPASSWORD=${POSTGRES_PASSWORD} pg_restore -h database -U ${DB_USER} --clean --if-exists -d ${DB_NAME} /data/${FILENAME}

echo "Restore complete"
