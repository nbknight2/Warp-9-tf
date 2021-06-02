# //////////////////////////////
# VARIABLES
# //////////////////////////////
variable "aws_access_key" {}

variable "aws_secret_key" {}


# //////////////////////////////
# Provider
# //////////////////////////////
provider "aws" {
  region = "us-east-1"
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
}

# //////////////////////////////
# Provider
# //////////////////////////////

resource "aws_vpc" "myvpc" {
  cidr_block = "10.0.0.16"
}
