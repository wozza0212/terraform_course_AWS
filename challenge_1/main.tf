provider "aws" {
    region = "eu-west-1"
}

variable "mycidrrange" {
    type = string
    default = "192.168.0.0/24"
}

variable "nametag" {
    type = map
    default = {
        Name = "TerraformVPC"
    }
}


resource "aws_vpc" "challenge1vpc" {
    cidr_block = var.mycidrrange
    tags = var.nametag
    
}