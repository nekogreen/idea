#!/bin/bash
set -euo pipefail

WORKSPACE=$(
  cd "$(dirname "${0}")"
  pwd
)

backup() {
  if [ -z "${NEKOGREEN_BACKUP_FROM:-}" ] || [ -z "${NEKOGREEN_BACKUP_STAGING:-}" ] || [ -z "${NEKOGREEN_BACKUP_TO:-}" ]; then
    cat <<EOF

Please set the following environment variables:

  - NEKOGREEN_BACKUP_FROM
  - NEKOGREEN_BACKUP_STAGING
  - NEKOGREEN_BACKUP_TO

EOF
    exit 1
  fi
  synchronize "$NEKOGREEN_BACKUP_FROM" "$NEKOGREEN_BACKUP_STAGING"
  synchronize "$NEKOGREEN_BACKUP_STAGING" "$NEKOGREEN_BACKUP_TO"
}

synchronize() {
  FROM_DIR=$1
  TO_DIR=$2

  MESSAGE="FROM_DIR=${FROM_DIR}"
  while [ ! -d "${FROM_DIR}" ]; do
    please_wait "$MESSAGE"
  done
  ok "$MESSAGE"

  MESSAGE="TO_DIR=${TO_DIR}"
  while [ ! -d "${TO_DIR}" ]; do
    please_wait "$MESSAGE"
  done
  ok "$MESSAGE"
  rsync -avz --delete --exclude=".*" "${FROM_DIR}/" "${TO_DIR}/"
}

usage() {
  echo "Workspace: ${WORKSPACE}"
  echo "Usage: ${0} [OPTION] ${1:-[PARAMETER]}"
  exit 1
}

please_wait() {
  MESSAGE=$1
  for C in . .. ...; do
    printf "%$(tput cols)s\r"
    echo -en "   [$MESSAGE] Please wait$C\r"
    sleep 0.3
  done
}

ok() {
  MESSAGE=$1
  printf "%$(tput cols)s\r"
  echo "OK [$MESSAGE]"
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
backup
