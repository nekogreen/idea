#!/bin/bash
set -euo pipefail
WORKSPACE=$(
  cd "$(dirname "${0}")"
  pwd
)

pings() {
  for HOST in "$@"; do
    PONG=$(ping -c1 -t1 ${HOST} 2>&1 || :)
    RESULT=$(echo "${PONG}" | awk -F'[()]' '{print $2}')
    [ -z "${RESULT}" ] && RESULT="${PONG}"
    printf "%s\t%s\n" "${HOST}" "${RESULT}"
  done
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
pings "$@"
