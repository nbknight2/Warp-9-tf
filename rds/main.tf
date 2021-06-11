# ///////////////////////////////
# Variables
# ///////////////////////////////
variable "aws_access_key" {}
variable "aws_secret_key" {}

# ///////////////////////////////
# Variables
# ///////////////////////////////
provider "aws" {
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
  region = "us-east-1"
}

resource "aws_db_instance" "myRDS" {
  name = "myDB"
  identifier = "my-first-rds"
  instance_class = "db.t2.micro"
  engine = "mariadb"
  engine_version = "10.2.21"
  username = "bob"
  password = "password123"
  port = 3306
  allocated_storage = 20
  skip_final_snapshot = true
}
