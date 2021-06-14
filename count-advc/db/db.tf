# Create a db server
## DB Server IP should be in output
variable "server_names" {
  type = list(string)
}


resource "aws_instance" "dbserver" { // Needs ami, instance type
  ami           = "ami-0d5eff06f840b45e9"
  instance_type = "t2.micro"
  count = length(var.server_names)

  tags = {
    Name = var.server_names[count.index]
  }
}

output "PrivateIP" {
  value = [aws_instance.dbserver.*.private_ip]
}
