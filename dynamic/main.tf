# ami-0d5eff06f840b45e9
# /////////////////////////
# Variables
# /////////////////////////

variable "aws_access_key" {}
variable "aws_secret_key" {}

variable "ingressrules" {
  type = list(number)
  default = [80,443]
}

variable "egressrules" {
  type = list(number)
  default = [80,443,25,3306,53,8080]
}

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
  dynamic "ingress" {
    iterator = port
    for_each = var.ingressrules
    content {
    from_port   = port.value
    to_port     = port.value
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
    }
  }
  dynamic "egress" {
    iterator = port
    for_each = var.egressrules
    content {
    from_port   = port.value
    to_port     = port.value
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
    }
  }
}


# /////////////////////////
# Output
# /////////////////////////

output "EIP" {
  value = aws_eip.elasticeip.public_ip
}
