terraform {
  required_version = ">0.12"
}

locals {
  demo-node-userdata = <<USERDATA
#!/bin/bash
set -o xtrace
/etc/eks/bootstrap.sh '${data.aws_eks_cluster.cluster.name}' --apiserver-endpoint '${data.aws_eks_cluster.cluster.id}' --b64-cluster-ca '${data.aws_eks_cluster.cluster.certificate_authority.0.data}'
USERDATA

}

locals {
  config_map_aws_auth = <<CONFIGMAPAWSAUTH


apiVersion: v1
kind: ConfigMap
metadata:
  name: aws-auth
  namespace: kube-system
data:
  mapRoles: |
    - rolearn: ${aws_iam_role.worker-cluster.arn}
      username: system:node:{{EC2PrivateDNSName}}
      groups:
        - system:bootstrappers
        - system:nodes
CONFIGMAPAWSAUTH

}