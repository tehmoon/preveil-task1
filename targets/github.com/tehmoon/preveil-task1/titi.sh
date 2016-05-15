#!/usr/bin/env bash

DIR=${1}

cd ${DIR}

make install 2>&1 > /dev/null

find bin/
