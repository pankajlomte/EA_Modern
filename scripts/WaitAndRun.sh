#!/usr/bin/env bash

set -e
set -x

until [ ]; do
   dotnet "$1" && break
   sleep 1
done

while true; do if curl -s -m 5 -o /dev/null http://selenium-hub:4444/wd/hub/status; then echo "OK: $(date)"; else echo "FAIL: $(date)"; fi; sleep 5; done

dotnet test --logger "console;verbosity=detailed"
