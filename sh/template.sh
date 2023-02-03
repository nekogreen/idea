#!/bin/bash
set -euo pipefail
WORKSPACE=$(
  cd "$(dirname "${0}")"
  pwd
)

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
usage
