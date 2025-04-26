provider "aws" {
    region = "eu-west-1"
}

variable "myAmiId" {
    type = string
    default = "ami-0ce8c2b29fcc8a346"
}

variable "instanceType" {
    type = string
    default = "t2.micro"
}

resource "aws_instance" "myec2" {
    ami = var.myAmiId
    instance_type = var.instanceType
}


resource "aws_eip" "myelasticip" {
    instance = aws_instance.myec2.id
}

output "myinstanEIPceid" {
    value = aws_eip.myelasticip.public_ip
}