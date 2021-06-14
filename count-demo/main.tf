/* Use these for training purposes
   Ami = ami-0d5eff06f840b45e9
   Instance type = t2.micro
*/
# ///////////////////////
# Variables
# ///////////////////////
variable "aws_access_key" {}
variable "aws_secret_key" {}

# ///////////////////////
# Provider
# ///////////////////////
provider "aws" {
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
  region = "us-east-1"
}

# ///////////////////////
# Resource
# ///////////////////////
resource "aws_instance" "ec2" {
  ami = "ami-0d5eff06f840b45e9"
  instance_type = "t2.micro"
  count = 3
}

# ///////////////////////
# Output
# ///////////////////////
