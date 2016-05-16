#!/usr/bin/env bash

cd ${1}
go build -o cbpipe . 2>&1 > /dev/null && echo cbpipe
