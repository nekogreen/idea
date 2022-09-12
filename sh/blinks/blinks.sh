#!/bin/bash
set -euo pipefail

WORKING_DIR="$(basename "$(pwd)")"
EXECUTABLE_DIR="eyes"

blinks() {
  if [ "${WORKING_DIR}" != "${EXECUTABLE_DIR}" ]; then
    echo "No executable directory. EXECUTABLE_DIR='${EXECUTABLE_DIR}'"
    return
  fi

  TYPES=(js json sh sql txt yaml)
  for TYPE in "${TYPES[@]}"; do
    blink "${TYPE}"
  done
}

blink() {
  TYPE=${1}
  [ -e "${TYPE}" ] || mkdir "${TYPE}"
  for NO in $(seq -f %02g 1 5); do
    UPPER_TYPE=$(echo "${TYPE}" | tr '[:lower:]' '[:upper:]')
    cat /dev/null >"${TYPE}/${UPPER_TYPE}-$NO-LEFT.${TYPE}"
    cat /dev/null >"${TYPE}/${UPPER_TYPE}-$NO-RIGHT.${TYPE}"
  done
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
blinks
