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

variable "ingressrules" {
    type = list(number)
    default = [80, 443]
}

variable "egressrules" {
    type = list(number)
    default = [80, 443, 25, 3306, 53, 8080]
}

resource "aws_security_group" "webtraffic" {
    name = "Allow HTTPS"

    dynamic "ingress" {
        iterator = port
        for_each = var.ingressrules
        content {
        from_port = port.value
        to_port = port.value
        protocol = "TCP"
        cidr_blocks = ["0.0.0.0/0", "89.22.199.29/32"]
        }
    }
    
    dynamic "egress" {
        iterator = port
        for_each = var.egressrules
        content {
        from_port = port.value
        to_port = port.value
        protocol = "TCP"
        cidr_blocks = ["0.0.0.0/0", "89.22.199.29/32"]
        }
    }
}