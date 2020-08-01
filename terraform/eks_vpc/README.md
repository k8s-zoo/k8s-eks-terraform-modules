# EKS VPC

## Introduction

Terraform modules create VPC for AWS EKS.

## Development

### Example

```hcl-terraform

provider "aws" {
  region = "us-west-2"
}

module "eks_vpc" {
  source = "git@github.com/k8s-zoo/k8s-eks-terraform-modules.git//terraform/eks_vpc"

  cluster_name            = "mishal-learn"
  owner                   = "mishalshah92@gmail.com"
  stack                   = "demo"
  env                     = "learn"
}

```
 
**Variables**: For info on variables, check [file](variables.tf)