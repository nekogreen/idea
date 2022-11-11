#!/bin/bash
set -euo pipefail

white_and_black() {
  synchronize /Volumes/WHITE/Numbers /Volumes/BLACK/Numbers
  synchronize /Volumes/WHITE/image /Volumes/BLACK/image
}

synchronize() {
  WHITE_DIR=$1
  BLACK_DIR=$2
  if [ ! -d "${WHITE_DIR}" ]; then
    echo "Directory not found. ${WHITE_DIR}"
    exit 1
  fi
  if [ ! -d "${BLACK_DIR}" ]; then
    echo "Directory not found. ${BLACK_DIR}"
    exit 1
  fi
  rsync -av --delete "${WHITE_DIR}/" "${BLACK_DIR}/"
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
white_and_black
