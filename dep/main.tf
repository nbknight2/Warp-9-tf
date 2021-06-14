# ////////////////////////////
# Variables
# ////////////////////////////
variable "aws_access_key" {}
variable "aws_secret_key" {}

# ////////////////////////////
# Provider
# ////////////////////////////
provider "aws" {
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
  region = "us-east-1"
}

# ////////////////////////////
# Resources
# ////////////////////////////

resource "aws_instance" "db" {
  ami = "ami-0d5eff06f840b45e9"
  instance_type = "t2.micro"
}

resource "aws_instance" "web" {
  ami = "ami-0d5eff06f840b45e9"
  instance_type = "t2.micro"

  depends_on = [
    aws_instance.db
  ]
}

