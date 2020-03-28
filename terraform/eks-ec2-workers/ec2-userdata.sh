#!/bin/bash

set -o xtrace

echo "preserve_hostname: true" >> /etc/cloud/cloud.cfg
hostnamectl set-hostname $(curl -s http://169.254.169.254/latest/meta-data/hostname | cut -d' ' -f2 | cut -d. -f1)
rm -rf /var/lib/cloud/instances/
systemctl restart systemd-hostnamed.service
systemctl restart cloud-init

/etc/eks/bootstrap.sh --apiserver-endpoint '${cluster_endpoint}' --b64-cluster-ca '${cluster_certificate_authority}' '${cluster_name}'

systemctl restart kubelet