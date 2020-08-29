#!/usr/bin/bash
set -e

source /app/.env

export AWS_ACCESS_KEY_ID=${AWS_ACCESS_KEY_ID:?"AWS_ACCESS_KEY_ID is required"}
export AWS_SECRET_ACCESS_KEY=${AWS_SECRET_ACCESS_KEY:?"AWS_SECRET_ACCESS_KEY is required"}
export AWS_DEFAULT_REGION=${AWS_DEFAULT_REGION:?"AWS_DEFAULT_REGION is required"}
MONGO_URI=${MONGO_URI:?"MONGO_URI is required"}
AWS_BUCKET_DIR=${AWS_BUCKET_DIR:?"AWS_BUCKET_DIR is required"}
BACKUP_FILE=${BACKUP_FILE:?"BACKUP_FILE is required"}

fname="/backup/$BACKUP_FILE.tar.gz"

mkdir -p /backup

echo "Dumping Mongo database..."
mongodump --uri "$MONGO_URI" --gzip --archive="$fname"

echo "Uploading to S3..."
aws s3 cp "$fname" "$AWS_BUCKET_DIR/"

echo "Done"