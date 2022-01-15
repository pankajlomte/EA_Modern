#!/usr/bin/env sh

set -e
set -x

project="e2etest"

export COMPOSE_HTTP_TIMEOUT=200

docker-compose -p "$project" build

mkdir -m 777 reports
ls -l
docker-compose -p "$project" up -d ea_api ea_webapp db selenium-hub firefox chrome
docker-compose -p "$project" up --no-deps ea_test

ls -l
echo "TestExecution.json file copied to reports folder"	
ls -l ./reports

exit_code=$(docker inspect ${project}_ea_test_1 -f '{{ .State.ExitCode }}')

if [ $exit_code -eq 0 ]; then
    exit $exit_code
else
    echo "Test failed"
fi