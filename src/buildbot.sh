#!/usr/bin/env bash
set -e

GIT_URL=${1}

usage() {
	MSG=${1}
	[ ! "x${MSG}" = "x" ] && echo ${MSG} > /dev/stderr

	echo "./bin/buildbot.sh <git_url>" > /dev/stderr

	exit 2
}

[ "x${GIT_URL}" = "x" ] && usage

echo $GIT_URL

start() {
	while true
	do
		echo "sleep"
	  sleep  1
	done
}

start
