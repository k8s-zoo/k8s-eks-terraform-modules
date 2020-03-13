resource "aws_cloudwatch_log_group" "master-cluster-cw-loggroup" {
  name              = "/aws/eks/${var.cluster_name}/cluster"
  retention_in_days = var.log_retention_in_days

  tags = {
    Name  = local.name_prefix
    owner = var.owner
    stack = var.stack
    env   = var.env
  }
}