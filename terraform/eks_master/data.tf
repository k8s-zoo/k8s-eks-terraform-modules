data "aws_caller_identity" "current" {
}

data "aws_iam_policy_document" "master-node-assume-policy" {

  statement {

    effect = "Allow"
    principals {
      identifiers = ["eks.amazonaws.com"]
      type        = "Service"
    }

    actions = ["sts:AssumeRole"]
  }
}