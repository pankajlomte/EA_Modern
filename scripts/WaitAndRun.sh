#!/usr/bin/env bash

set -e
set -x

until [ ]; do
   dotnet "$1" && break
   sleep 1
done

until [ ]; do
  curl -f "http://selenium-hub:4444/wd/hub/status" && break
  sleep 10
done

dotnet test --logger "console;verbosity=detailed"
