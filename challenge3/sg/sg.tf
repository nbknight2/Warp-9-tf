# Create a list of ingress rules
variable "ingress" {
  type    = list(number)
  default = [80, 443]
}

# Create a list of egress rules
variable "egress" {
  type    = list(number)
  default = [80, 443]
}

output "sg_name" {
  value = aws_security_group.webAccess.name
}
# Create a security vroup for the web server
### Needs a name, ingress info.
#### Multiple ports so it needs to iterate through a list.
resource "aws_security_group" "webAccess" {
  name = "HTTPandHTTPSaccess"
  dynamic "ingress" {
    iterator = port
    for_each = var.ingress
    content {
      from_port   = port.value
      to_port     = port.value
      protocol    = "TCP"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

  dynamic "egress" {
    iterator = port
    for_each = var.egress
    content {
      from_port   = port.value
      to_port     = port.value
      protocol    = "-1"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }
}

