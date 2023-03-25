#!/bin/bash
set -euo pipefail
WORKSPACE=$(
  cd "$(dirname "${0}")"
  pwd
)

teacher() {
  if [ ! -d "${TEACHER_CHROME_USER_DATA:-}" ]; then
    echo 'Please export TEACHER_CHROME_USER_DATA=<YOUR CHROME USER DATA>'
    exit 1
  fi
  if [ -z "${TEACHER_CHROME_URL:-}" ]; then
    echo 'Please export TEACHER_CHROME_URL=<YOUR CHROME URL>'
    exit 1
  fi
  '/Applications/Google Chrome.app/Contents/MacOS/Google Chrome' --user-data-dir="${TEACHER_CHROME_USER_DATA}" "${TEACHER_CHROME_URL}" >/dev/null 2>&1
}

usage() {
  echo "Workspace: ${WORKSPACE}"
  echo "Usage: ${0} [OPTION] ${1:-[PARAMETER]}"
  exit 1
}

please_wait() {
  for C in . .. ...; do
    printf "%$(tput cols)s\r"
    echo -en "Please wait$C\r"
    sleep 0.3
  done
}

while getopts :u: OPT; do
  case ${OPT} in
  u)
    usage "${OPTARG}"
    ;;
  \?)
    usage
    ;;
  esac
done
shift $((OPTIND - 1))
teacher
