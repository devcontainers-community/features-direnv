#!/bin/bash

# https://github.com/devcontainers/features/blob/9fd5daf06b40794a067c4cdbb8e258d99eeefc24/src/node/install.sh
apt_get_update() {
    if [ "$(find /var/lib/apt/lists/* | wc -l)" = "0" ]; then
        echo "Running apt-get update..."
        apt-get update -y
    fi
}

# https://github.com/devcontainers/features/blob/9fd5daf06b40794a067c4cdbb8e258d99eeefc24/src/node/install.sh
# Checks if packages are installed and installs them if not
check_packages() {
    if ! dpkg -s "$@" > /dev/null 2>&1; then
        apt_get_update
        apt-get -y install --no-install-recommends "$@"
    fi
}
