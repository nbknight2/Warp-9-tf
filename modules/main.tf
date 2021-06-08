# //////////////////////////
# Variables
# //////////////////////////

variable "aws_access_key" {}
variable "aws_secret_key" {}

# //////////////////////////
# provider
# //////////////////////////
provider "aws" {
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
  region = "us-east-1"
}

# //////////////////////////
# Modules
# //////////////////////////

module "ec2module" {
  source = "./ec2"
  ec2name = "Name from Module"
}

# //////////////////////////
# Output
# //////////////////////////

output "module_output" {
  value = module.ec2module.instance_id
}
