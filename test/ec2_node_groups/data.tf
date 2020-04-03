data "aws_vpc" "vpc" {
  filter {
    name   = "tag:Name"
    values = ["PrimaryVPC"]
  }
}

data "aws_subnet_ids" "subnets" {
  vpc_id = data.aws_vpc.vpc.id

  tags = {
    Tier = "App"
  }
}