#!/bin/bash -x

curl -w '\n\nEstablish Connection: %{time_connect}s\nTotal: %{time_total}s\n' -H "Host: open-liberty-instanton.default.example.com" http://localhost:8080/dev/system/properties
