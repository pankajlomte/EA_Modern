#!/usr/bin/env sh

set -e
set -x

project="e2etest"

export COMPOSE_HTTP_TIMEOUT=200
export REPORT_DIRECTORY="/report"

docker-compose -p "$project" build

docker-compose -p "$project" up -d ea_api ea_webapp db selenium-hub node-docker
docker-compose -p "$project" up --no-deps ea_test
exit_code=$(docker inspect ${project}_ea_test_1 -f '{{ .State.ExitCode }}')

if [ $exit_code -eq 0 ]; then
    exit $exit_code
else
    echo "Test failed"
fi

rm -rf ./report
docker cp ${project}_ea_test_1:$REPORT_DIRECTORY ./report
