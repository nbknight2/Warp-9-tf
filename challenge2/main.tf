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

# Create a list of ingress rules
variable "ingressRule" {
  type    = list(number)
  default = [80, 443]
}

# Create a list of egress rules
variable "egress" {
  type    = list(number)
  default = [80, 443]
}


# ////////////////////////
# Providers
# ////////////////////////

provider "aws" { // Needs the auth creds and the region
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
  region     = "us-east-1"
}

# ////////////////////////
# Resources
# ////////////////////////

# Create a db server
## DB Server IP should be in output

resource "aws_instance" "dbserver" { // Needs ami, instance type
  ami           = "ami-0d5eff06f840b45e9"
  instance_type = "t2.micro"
}

# Create a web server


resource "aws_instance" "webserver" {
  ami             = "ami-0d5eff06f840b45e9"
  instance_type   = "t2.micro"
  security_groups = [aws_security_group.webAccess.name]
  user_data = file("server-script.sh")
}

## Give it an EIP and attach it to the webserver.
resource "aws_eip" "webserverEip" {
  instance = aws_instance.webserver.id
}

# Create a security vroup for the web server
### Needs a name, ingress info.
#### Multiple ports so it needs to iterate through a list.
resource "aws_security_group" "webAccess" {
  name = "HTTPandHTTPSaccess"
  dynamic "ingress" {
    iterator = port
    for_each = var.ingressRule
    content {
      from_port   = port.value
      to_port     = port.value
      protocol    = "TCP"
      cidr_blocks = "0.0.0.0/24"
    }
  }

  dynamic "egress" {
    iterator = port
    for_each = var.egress
    content {
      from_port   = port.value
      to_port     = port.value
      protocol    = "-1"
      cidr_blocks = "0.0.0.0/24"
    }
  }
}


# ////////////////////////
# Output
# ////////////////////////

output "dbserverIP" {
  value = aws_instance.dbserver.private_ip
}

output "publicIP" {
  value = aws_eip.webserverEip.public_ip
}
