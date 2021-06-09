# AMI to use: ami-0d5eff06f840b45e9
# Need variables, providers, resources, outputs
# ////////////////////////
# Variables
# ////////////////////////

/*
Add access variables so that the right account is being used.
*/
variable "aws_access_key" {}
variable "aws_secret_key" {}

# ////////////////////////
# Providers
# ////////////////////////

provider "aws" { // Needs the auth creds and the region
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
  region     = "us-east-1"
}

# ////////////////////////
# Modules
# ////////////////////////

module "db" {
  source = "./db"

}

module "web" {
  source = "./web"
  
}
# ////////////////////////
# Output
# ////////////////////////

output "PrivateIP" {
  value = module.db.PrivateIP
}

output "publicIP" {
  value = module.web.pub_ip
}
