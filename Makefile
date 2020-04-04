TESTS_PATH:="test"
TEST_COMMONS_VAR_FILE:="test/commons.tfvars"
TEST_EKS_MASTER:="test/eks_master"
TEST_EKS_MASTER_VAR_FILE:="test/eks_master.tfvars"
TEST_EKS_NODE_GROUP:="test/eks_node-group"
TEST_EKS_NODE_VAR_FILE:="test/eks_node_group.tfvars"
TEST_EC2_NODE_GROUP:="test/ec2_node_groups"
TEST_EC2_NODE_VAR_FILE:="test/ec2_node_group.tfvars"

validate:
	terraform init $(TEST_EKS_MASTER) && terraform validate $(TEST_EKS_MASTER)
	terraform init $(TEST_EKS_NODE_GROUP) && terraform validate $(TEST_EKS_NODE_GROUP)
	terraform init $(TEST_EC2_NODE_GROUP) && terraform validate $(TEST_EC2_NODE_GROUP)

deploy-master:
	terraform init $(TEST_EKS_MASTER)
	terraform apply -var-file=$(TEST_COMMONS_VAR_FILE) -var-file=$(TEST_EKS_MASTER_VAR_FILE) --auto-approve $(TEST_EKS_MASTER)

destroy-master:
	terraform init $(TEST_EKS_MASTER)
	terraform destroy -var-file=$(TEST_COMMONS_VAR_FILE) -var-file=$(TEST_EKS_MASTER_VAR_FILE) --auto-approve $(TEST_EKS_MASTER)

deploy-ec2-nodes:
	terraform init $(TEST_EC2_NODE_GROUP)
	terraform apply -var-file=$(TEST_COMMONS_VAR_FILE) -var-file=$(TEST_EC2_NODE_VAR_FILE) --auto-approve $(TEST_EC2_NODE_GROUP)

destroy-ec2-nodes:
	terraform init $(TEST_EC2_NODE_GROUP)
	terraform destroy -var-file=$(TEST_COMMONS_VAR_FILE) -var-file=$(TEST_EC2_NODE_VAR_FILE) --auto-approve $(TEST_EC2_NODE_GROUP)

deploy-eks-nodes:
	terraform init $(TEST_EKS_NODE_GROUP)
	terraform apply -var-file=$(TEST_COMMONS_VAR_FILE) -var-file=$(TEST_EKS_NODE_VAR_FILE) --auto-approve $(TEST_EKS_NODE_GROUP)

destroy-eks-nodes:
	terraform init $(TEST_EKS_NODE_GROUP)
	terraform destroy -var-file=$(TEST_COMMONS_VAR_FILE) -var-file=$(TEST_EKS_NODE_VAR_FILE) --auto-approve $(TEST_EKS_NODE_GROUP)