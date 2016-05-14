#!/usr/bin/env bash
set -e

GIT_URL=${1}
GIT_BRANCH=dev
TMP_DIR=tmp/

usage() {
	MSG=${1}

	[ ! "x${MSG}" = "x" ] && echo ${MSG} > /dev/stderr

	echo "./bin/buildbot.sh <git_url>" > /dev/stderr

	exit 2
}

[ "x${GIT_URL}" = "x" ] && usage

clean() {
	echo -n "Cleaning tmp dir... "

	[ "x${TMP_DIR}" = "x" ] && echo -e "NOK" > /dev/stderr && exit 2
	rm -rf ${TMP_DIR}/*
	echo "OK."
}

start() {
	echo ${GIT_TMP}
	while true
	do
		echo "sleep"
	  sleep  1
	done
}

checkout() {
	git clone ${GIT_URL} ${GIT_TMP}

	cd ${GIT_TMP}

	git checkout -b dev
}

checkout_and_start() {
	GIT_TMP=$(mktemp -d -p ${TMP_DIR})

	checkout
	start
}

check_path() {
	which git
}

env

check_path
clean
checkout_and_start
