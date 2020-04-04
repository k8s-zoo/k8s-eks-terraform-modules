#!/usr/bin/env bash

set -e
set -x

DATE=$(date +%Y.%m.%d-%H.%M.%S)
DOWNLOAD_URL=$(curl -Ls "https://api.github.com/repos/kubernetes-sigs/metrics-server/releases/latest" | jq -r .tarball_url)
DOWNLOAD_VERSION=$(grep -o '[^/v]*$' <<< "$DOWNLOAD_URL")
DOWNLOAD_DIR="/tmp/metrics-server-$DOWNLOAD_VERSION-$DATE"

mkdir -p "$DOWNLOAD_DIR"

cd "$DOWNLOAD_DIR" && curl -Ls "$DOWNLOAD_URL" -o metrics-server-"$DOWNLOAD_VERSION".tar.gz
tar -xzf metrics-server-"$DOWNLOAD_VERSION".tar.gz --directory "$DOWNLOAD_DIR" --strip-components 1
cd "$DOWNLOAD_DIR" && kubectl apply -f deploy/1.8+/
