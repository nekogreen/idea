#!/bin/bash
set -euo pipefail

beam() {
  COMMAND="${1}"
  FILE="${2}"

  if [ -z "${COMMAND}" ]; then
    echo "Command is empty. COMMAND=${COMMAND}"
    return
  fi
  if [[ "${COMMAND}" =~ (^|[^[:alnum:]])(rm|mkdir|mv)($|[^[:alnum:]]) ]]; then
    echo "Command is danger. COMMAND=${COMMAND}"
    return
  fi
  if [ ! -e "${FILE}" ]; then
    echo "File is empty. FILE=${FILE}"
    return
  fi

  echo "Let's beam!"
  HOSTS=$(grep -Ev "^#" <"${FILE}")
  for HOST in ${HOSTS}; do
    echo "ssh \"ec2-user@${HOST}\" \"${COMMAND}\""
    # shellcheck disable=SC2029
    ssh "ec2-user@${HOST}" "${COMMAND}" || :
  done
}

usage() {
  echo "Usage: $0 [OPTION] ${1:-[PARAMETER]}"
  exit 1
}

while getopts :u:c:f: OPT; do
  case ${OPT} in
  c)
    COMMAND="${OPTARG}"
    ;;
  f)
    FILE="${OPTARG}"
    ;;
  u)
    usage "${OPTARG}"
    ;;
  \?)
    usage
    ;;
  esac
done
shift $((OPTIND - 1))
beam "${COMMAND:-}" "${FILE:-}"
