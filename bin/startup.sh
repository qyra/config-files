#!/bin/bash
set -euo pipefail

cd $ENTRUPY_PROJECTS/local-development-scripts
make create-dynamodb-tables
make create-s3-buckets

echo "Flushing, and importing app-api-public data (Dev)"
cd $ENTRUPY_PROJECTS/local-development-scripts/dynamodb
poetry env use python3.11

# Required for public API tests.
time $ENTRUPY_PROJECTS/app-api-public/tests/test_data/import_test_data.sh

# DUMP_PATH="$ENTRUPY_PROJECTS/app-api-public/tests/data/test-dumps/public_api-test-dump__2024-04-23__karl.dump/dev"
# time $ENTRUPY_PROJECTS/local-development-scripts/dynamodb/import_dump_poetry.sh -i $DUMP_PATH -d app --quiet --targets --flush

# DUMP_PATH="$ENTRUPY_PROJECTS/app-api-public/tests/data/test-dumps/public_api-test-dump__2024-04-23__karl.dump/prod"
# time $ENTRUPY_PROJECTS/local-development-scripts/dynamodb/import_dump_poetry.sh -i $DUMP_PATH -d app --quiet --targets

# # Required for app-model-service real item tests?
# DUMP_PATH="/Users/karl/data/v2-dumps/2023-10-13-ams-dev-test-items"
# time $ENTRUPY_PROJECTS/local-development-scripts/dynamodb/import_dump_poetry.sh -i $DUMP_PATH -d app --quiet --targets

# DUMP_PATH="/Users/karl/data/v2-dumps/2023-11-29-ams-prod-test-items"
# time $ENTRUPY_PROJECTS/local-development-scripts/dynamodb/import_dump_poetry.sh -i $DUMP_PATH -d app --quiet --targets

echo "Import complete"
