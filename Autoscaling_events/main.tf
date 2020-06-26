provider "aws" {
  profile    = "default"
  region     = "eu-west-1"
}

resource "aws_sns_topic" "user_updates" {
  name = "scale_event"
  display_name = "scale_event"
}

data "aws_iam_policy_document" "instance-assume-role-policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "role_for_lambda" {
  name               = "instance_role"
  path               = "/system/"
  assume_role_policy = data.aws_iam_policy_document.instance-assume-role-policy.json
}

resource "aws_lambda_function" "test_lambda" {
//  filename      = "lambda_function_payload.zip"
  function_name = "lambda_function_name"
  role          = aws_iam_role.role_for_lambda.arn
  handler       = "exports.test"
  runtime = "python3.7"
}
