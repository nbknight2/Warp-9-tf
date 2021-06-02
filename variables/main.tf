# //////////////////////////////
# VARIABLES
# //////////////////////////////


variable "aws_access_key" {}

variable "aws_secret_key" {}

variable "vpcname" {
  type = string
  default = "myvpc"
}

variable "sshport" {
  type = number
  default = 22
}

variable "enabled" {
  default = true    
}

variable "mylist" {
  type=list(string)
  default = ["Value1","Value2"]
}

variable "mymap" {
  type = map
  default = {
    Key1 = "Value1"
    Key2 = "Value2"
  }
}

variable "inputname" {
  type = string
  description = "Set the name of the VPC"
}

variable "mytuple" {
  type = tuple([string, number, string])
  default = ["cat", 1, "dog"]
}

variable "myobject" {
  type = object({name = string, port = list(number)})
  default = {
    name = "Nick"
    port = [22,25,80]
  }
}

# //////////////////////////////terr
# Provider
# //////////////////////////////

provider "aws" {
  region = "us-east-1"
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
}

# //////////////////////////////
# Resource
# //////////////////////////////

resource "aws_vpc" "myvpc" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = var.inputname
  }
}

# //////////////////////////////
# Output
# //////////////////////////////

output "vpcid" {
  value = aws_vpc.myvpc.id
}
