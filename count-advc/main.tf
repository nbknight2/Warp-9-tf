/* Use these for training purposes
   Ami = ami-0d5eff06f840b45e9
   Instance type = t2.micro
*/
# ///////////////////////
# Variables
# ///////////////////////
variable aws_access_key {}
variable aws_secret_key {}

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
module "db" {
   source = "./db"
   server_names = ["mariadb","mysql","mssql"]
}
# ///////////////////////
# Resource
# ///////////////////////

# ///////////////////////
# Output
# ///////////////////////

output "private_ips" {
   value = module.db.PrivateIP
}
