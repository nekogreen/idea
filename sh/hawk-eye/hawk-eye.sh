#!/bin/bash
set -euo pipefail

hawk_eye() {
  for PROJECT_ROOT_PATH in $(find "$(pwd)" -type d -depth 1 | sort); do
    cd "${PROJECT_ROOT_PATH}"
    PROJECT_ROOT=$(basename "${PROJECT_ROOT_PATH}")
    [ -e .git ] || continue

    git fetch
    CURRENT_BRANCH=$(git branch --show-current)
    UP_TO_DATE=$(git status | grep 'up to date' >/dev/null 2>&1 && echo "/" || echo "*")
    HAS_REMOTE_DEVELOP=$(git branch -a | grep -e 'remotes/upstream/develop' >/dev/null 2>&1 && echo true || echo false)
    GIT_DIFF=$(git diff --exit-code --quiet && echo "-" || echo "+")
    if [ "${GIT_DIFF}" == "+" ]; then
      echo "${PROJECT_ROOT} ${CURRENT_BRANCH} ${GIT_DIFF} ${UP_TO_DATE}"
      continue
    fi
    if [ "${CURRENT_BRANCH}" == "master" ] && ${HAS_REMOTE_DEVELOP}; then
      echo "${PROJECT_ROOT} ${CURRENT_BRANCH} ${GIT_DIFF} ${UP_TO_DATE}"
      continue
    fi
    if [ "${CURRENT_BRANCH}" != "master" ] && [ "${CURRENT_BRANCH}" != "develop" ]; then
      echo "${PROJECT_ROOT} ${CURRENT_BRANCH} ${GIT_DIFF} ${UP_TO_DATE}"
      continue
    fi
    HAS_TRACKED_DEST=$(git branch -vv | grep -e "^\*.*\[upstream/${CURRENT_BRANCH}\]" >/dev/null 2>&1 && echo true || echo false)
    if ! ${HAS_TRACKED_DEST}; then
      echo "${PROJECT_ROOT} ${CURRENT_BRANCH} ${HAS_TRACKED_DEST}"
      continue
    fi
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
hawk_eye
