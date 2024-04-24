#!/bin/bash
set -euo pipefail

cd $ENTRUPY_PROJECTS/local-development-scripts
make create-dynamodb-tables
make create-s3-buckets

echo "Flushing, and importing app-api-public data (Dev)"
time erun import -i /home/karl/projects/app-api-public/tests/data/test-dumps/public_api-test-dump__2024-04-09__karl.dump/dev -d app --quiet --targets --flush

echo "Importing app-api-public data (Prod)"
time erun import -i /home/karl/projects/app-api-public/tests/data/test-dumps/public_api-test-dump__2024-04-09__karl.dump/prod -d app --quiet --targets

# echo "Importing app-endpoint data"
# $ENTRUPY_PROJECTS/app-endpoint/tests_v2/data/import_test_data.sh

echo "Import complete"
