provider "aws" {
    region = "eu-west-1"
}

resource "aws_iam_user" "lambda_user" {
    name = "iam_lambda_user"
}

resource "aws_iam_policy" "lambdapolicy" {
    name = "AWSLambdaPolicy"
    policy = file("templates/lambda-policy.json")
}

resource "aws_iam_policy_attachment" "policyBind" {
    name = "attachment"
    users = [aws_iam_user.lambda_user.name]
    policy_arn = aws_iam_policy.lambdapolicy.arn
}