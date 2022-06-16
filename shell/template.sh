#!/bin/bash
set -euo pipefail

example() {
  WORD=$1
  echo "${WORD}"
}

usage() {
  OPTIONS=$(grep -E -o '^while getopts [^ ]+' <"$0" | awk '{print $3}')
  example "Usage: $0 [-${OPTIONS}]" 1>&2
  exit 1
}

while getopts hx: OPT; do
  case ${OPT} in
  x)
    EXAMPLE_OPT=yes
    EXAMPLE_OPT_ARG="${OPTARG}"
    ;;
  h)
    usage
    ;;
  \?)
    usage
    ;;
  esac
done

shift $((OPTIND - 1))

[ "x${EXAMPLE_OPT:-no}" == "xyes" ] && example "${EXAMPLE_OPT_ARG}"
