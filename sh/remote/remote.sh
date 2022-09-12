#!/bin/bash
set -euo pipefail

remote() {
  HOSTS="$*"
  CSV_HOSTS="${HOSTS// /,}"
  echo "$#: ${CSV_HOSTS}"
  i2cssh -p remote -l ec2-user -C1 -m${CSV_HOSTS}
}

usage() {
  echo "Usage: ${0} [OPTION] ${1:-[PARAMETER]}"
  exit 1
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
remote "$@"
