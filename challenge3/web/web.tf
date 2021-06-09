# Create a web server
resource "aws_instance" "webserver" {
  ami             = "ami-0d5eff06f840b45e9"
  instance_type   = "t2.micro"
  security_groups = [module.sg.sg_name]
  # user_data = file("server-script.sh")
  tags = {
    Name = "Web Server"
  }
}

output "pub_ip" {
  value = module.eip.publicIP
}

module "eip" {
  source = "../eip"
  instance_id = aws_instance.webserver.id
  
}

module "sg" {
  source = "../sg"
  
}
