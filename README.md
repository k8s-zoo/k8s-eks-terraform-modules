# k8s-eks-terraform-modules

## Introduction

Terraform modules for creating kubernetes master and worker cluster on AWS [EKS](https://aws.amazon.com/eks/)

**Terraform version**: 0.12.23

## How to use?
- Master: See [example](test/eks_master/main.tf)
- Worker: See [example](test/ec2_node_groups/main.tf)

### Developing

```shell script
$ make [Target]
```

### **Targets**

- `$ make deploy-master name={cluster_name}`

    It will create the EKS cluster. Default aws region is `us-west-2`. 
    To override region, execute  `$ make deploy-master name={cluster_name} aws_region={region}`
 
- `$ make destroy-master name={cluster_name}`

    It will destroy the EKS cluster. Default aws region is `us-west-2`. 
    To override region, execute  `$ make destroy-master name={cluster_name} aws_region={region}    

- `$ make deploy-ec2-nodes name={cluster_name}`

    It will create the EC2 node group for EKS cluster. Default aws region is `us-west-2`. 
    To override region, execute  `$ make deploy-ec2-nodes name={cluster_name} aws_region={region}`
 
- `$ make destroy-ec2-nodes name={cluster_name}`

    It will destroy EC2 node group for EKS cluster. Default aws region is `us-west-2`. 
    To override region, execute `$ make destroy-ec2-nodes name={cluster_name} aws_region={region}`


#### Update local Kubernetes config
```shell script
$ aws eks --region {aws_region} update-kubeconfig --name {cluster_name}
```

#### Apply Kubernetes config.
```shell script
$ kubectl apply -f config_map_aws_auth.yaml
```

#### To view nodes
```shell script
$ kubectl get nodes --watch
```
    
## Overview

- **Maintainer**: mishalshah92@gmail.com