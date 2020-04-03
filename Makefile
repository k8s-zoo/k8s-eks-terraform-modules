name:='mishal-learn'
aws_region:='us-west-2'

deploy-master:
	cd test/master && terraform init && terraform apply -var='cluster_name=$(name)' -var='aws_region=$(aws_region)' --auto-approve

destroy-master:
	cd test/master && terraform init && terraform destroy -var='cluster_name=$(name)' -var='aws_region=$(aws_region)' --auto-approve

deploy-ec2-worker:
	cd test/worker && terraform init && terraform apply -var='cluster_name=$(name)' -var='master_sg_id=$(master_sg)' -var='aws_region=$(aws_region)' --auto-approve

destroy-ec2-worker:
	cd test/worker && terraform init && terraform destroy -var='cluster_name=$(name)' -var='aws_region=$(aws_region)' --auto-approve