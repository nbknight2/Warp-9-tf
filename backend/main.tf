# ///////////////////////////////
# Variables
# ///////////////////////////////
variable "aws_access_key" {}
variable "aws_secret_key" {}

# ///////////////////////////////
# Provider
# ///////////////////////////////
provider "aws" {
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
  region = "us-east-1"
}

# ///////////////////////////////
# Resources
# ///////////////////////////////
resource "aws_vpc" "test" {
  cidr_block = "10.0.0.0/16"
}
