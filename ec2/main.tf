# ami-0d5eff06f840b45e9
# /////////////////////////
# Variables
# /////////////////////////

variable "aws_access_key" {}
variable "aws_secret_key" {}

# /////////////////////////
# Provider
# /////////////////////////

provider "aws" {
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
  region     = "us-east-1"
}

# /////////////////////////
# Resource
# /////////////////////////

resource "aws_instance" "ec2" {
  ami             = "ami-0d5eff06f840b45e9"
  instance_type   = "t2.micro"
  security_groups = [aws_security_group.webtraffic.name]
}

resource "aws_eip" "elasticeip" {
  instance = aws_instance.ec2.id
}

resource "aws_security_group" "webtraffic" {
  name = "Allow_HTTPS"
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 443
    to_port     = 443
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }
}


# /////////////////////////
# Output
# /////////////////////////

output "EIP" {
  value = aws_eip.elasticeip.public_ip
}
