#!/usr/bin/env bash

set -e
set -x

DASHBOARD_VERSION=${1:-v2.0.0-beta8}
kubectl apply -f "https://raw.githubusercontent.com/kubernetes/dashboard/$DASHBOARD_VERSION/aio/deploy/recommended.yaml"