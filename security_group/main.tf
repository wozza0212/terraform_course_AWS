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
    security_groups = [aws_security_group.webtraffic.name]
}

resource "aws_security_group" "webtraffic" {
    name = "Allow HTTPS"

    ingress {
        from_port = 443
        to_port = 443
        protocol = "TCP"
        cidr_blocks = ["0.0.0.0/0", "89.22.199.29/32"]
    }

    egress {
        from_port = 443
        to_port = 443
        protocol = "TCP"
        cidr_blocks = ["0.0.0.0/0", "89.22.199.29/32"]
    }
}