variable "instance_id" {
  type = string
}
## Give it an EIP and attach it to the webserver.
resource "aws_eip" "webserverEip" {
  instance = var.instance_id
}

output "publicIP" {
  value = aws_eip.webserverEip.public_ip
}
