output "config_map_aws_auth" {
  value = local.config_map_aws_auth
}

output "node_cluster_sg_id" {
  value = aws_security_group.worker-node.id
}

output "node_cluster_asg" {
  value = aws_autoscaling_group.worker-asg.name
}

output "node_cluster_lc" {
  value = aws_launch_configuration.worker-lc.name
}

output "node_cluster_instance_role" {
  value = aws_iam_role.worker-instacne-role.name
}

output "node_cluster_role" {
  value = aws_iam_role.worker-cluster.name
}