#!/usr/bin/env bash

set -e
set -x

until [ ]; do
   dotnet "$1" && break
   sleep 1
done

until [ ]; do
   sleep 30
   curl -f "http://selenium-hub:4444/wd/hub/status" && break
done

dotnet test --logger "console;verbosity=detailed"
echo "Test finished"
echo "Getting container docker pwd"
docker exec ea_test pwd
docker cp ${project}_ea_test:./EATestBDD/bin/Debug/net6.0/TestExecution.json ./reports
