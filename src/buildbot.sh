#!/usr/bin/env bash
set -e

GIT_URL=${1}
GIT_BRANCH=dev
TMP_DIR=tmp
TARGET_PATH=targets

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
	CURRENT_COMMIT=$(get_cur_commit)

	while true
	do
		echo ${CURRENT_COMMIT}
		echo ${TASK_PATH}

		git_refresh && CURRENT_COMMIT=$(get_cur_commit)

	  sleep  1
	done
}

git_refresh() {
	cd ${GIT_TMP}

	git pull origin dev
	RET=$?

	cd -

  return ${RET}
}

get_cur_commit() {
	cd ${GIT_TMP}

	git log --pretty=format:%H -1

	cd -
}

checkout() {
	git clone ${GIT_URL} ${GIT_TMP}

	cd ${GIT_TMP}

	git checkout -b ${GIT_BRANCH} origin/${GIT_BRANCH}

	cd -
}

get_git_path() {
	cd ${GIT_TMP}

	REMOTE=$(git remote get-url --push origin)

	echo ${REMOTE} | grep '://' 2>&1 > /dev/null && echo ${REMOTE} | cut -d '/' -f 3- || ( \ # handling pattern like scheme://uri
	echo ${REMOTE} | grep '@' 2>&1 > /dev/null && echo ${REMOTE} | cut -d '@' -f 2- | sed 's/:/\//' | sed -e 's/\.git$//' ) # handling pattern like username@host:git_url

	cd -
}

checkout_and_start() {
	GIT_TMP=$(mktemp -d -p ${TMP_DIR})

	checkout

	GIT_PATH=$(get_git_path)
	TASK_PATH=${TARGET_DIR}/${GIT_PATH}

	start
}

check_path() {
	which git
}

check_path
clean
checkout_and_start
