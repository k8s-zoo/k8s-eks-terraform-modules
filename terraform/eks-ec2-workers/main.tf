terraform {
  required_version = ">0.12"
}

locals {

  name_prefix = "${data.aws_eks_cluster.eks-cluster.name}-eks-worker"
  path_prefix = "/${var.owner}/${var.aws_region}/${var.stack}/${var.env}/"

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