# ///////////////////////////////////////
# Variables
# ///////////////////////////////////////
variable "aws_access_key" {}
variable "aws_secret_key" {}

provider "aws" {
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
  region     = "us-east-1"
}

#  Creates the user
resource "aws_iam_user" "myuser" {
  name = "Nick"
}
#  Creates the policy
resource "aws_iam_policy" "customPolicy" {
  name = "GlacierEFSEC2"
  # Policy is pasted in the heredoc below
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
      {
          "Sid": "VisualEditor0",
          "Effect": "Allow",
          "Action": [
              "glacier:GetVaultAccessPolicy",
              "glacier:DescribeVault",
              "glacier:GetJobOutput",
              "glacier:GetVaultLock",
              "glacier:GetVaultNotifications",
              "glacier:DescribeJob"
          ],
          "Resource": "arn:aws:glacier:*:106415312828:vaults/*"
      },
      {
          "Sid": "VisualEditor1",
          "Effect": "Allow",
          "Action": "glacier:GetDataRetrievalPolicy",
          "Resource": "*"
      }
  ]
}
  EOF
}

#  Attaches the user to the policy
resource "aws_iam_policy_attachment" "policy_bind" {
  name       = "attachment"
  users      = [aws_iam_user.myuser.name]
  policy_arn = aws_iam_policy.customPolicy.arn
}
