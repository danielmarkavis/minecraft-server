#!/bin/bash

#########
# This is a copy/paste of the file from here:
# https://github.com/tekgator/docker-mcmyadmin/blob/781c05b0a6c3c3b49fe06af8399ffde81a5c3d77/usr/local/bin/docker-entrypoint.sh
# All credits go to the original developer (tekgator) and the contributors
#
# Repo: https://github.com/tekgator/docker-mcmyadmin
#########

set -e

SCRIPT_PATH="$( cd "$(dirname "$0")" ; pwd -P )"
DOCKER_USER='dockeruser'
DOCKER_GROUP='dockergroup'

if ! id "$DOCKER_USER" >/dev/null 2>&1; then
    echo -e "\nFirst start of the docker container, start initialization process."

    USER_ID=${PUID:-9001}
    GROUP_ID=${PGID:-9001}
    echo -e "\nStarting with"
    echo "UID: $USER_ID"
    echo "GID: $GROUP_ID"

    groupadd -f -g "$GROUP_ID" "$DOCKER_GROUP"
    useradd --shell /bin/bash -u "$USER_ID" -g "$GROUP_ID" -o -c "" -m "$DOCKER_USER"

    chown -R "$USER_ID":"$GROUP_ID" "/McMyAdmin/"
    chown -R "$USER_ID":"$GROUP_ID" "$SCRIPT_PATH"/entrypoint.sh
    chmod +x "$SCRIPT_PATH"/entrypoint.sh
fi
export HOME=/home/"$DOCKER_USER"

exec gosu "$DOCKER_USER" "$SCRIPT_PATH"/entrypoint.sh

