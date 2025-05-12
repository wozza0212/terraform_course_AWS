provider "aws" {
    region = "eu-west-1"
}

data "aws_caller_identity" "current" {}

data "aws_region" "current" {}

data "aws_iam_user" "user" {
  user_name = "tf-lambda-user"
}


resource "aws_iam_user" "tf_lambda_user" {
    name = "tf-lambda-user"
}

resource "aws_iam_policy" "fullaccesspolicy" {
    name = "AWSLambdaPolicy"
    policy = file("templates/full-lambda-policy.json")
}

resource "aws_iam_policy_attachment" "policyBind" {
    name = "attachment"
    users = [aws_iam_user.tf_lambda_user.name]
    policy_arn = aws_iam_policy.fullaccesspolicy.arn
}