#!/bin/bash

set -o xtrace

/etc/eks/bootstrap.sh '{cluster_name}' --apiserver-endpoint '{cluster_id}' --b64-cluster-ca '{cluster_certificate_authority}'