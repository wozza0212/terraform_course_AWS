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

resource "aws_instance" "DB" {
    ami = var.myAmiId
    instance_type = var.instanceType
    tags = {
        Name = "DB Server"
    }
}

resource "aws_instance" "wevserver" {
    ami = var.myAmiId
    instance_type = var.instanceType
    security_groups = [aws_security_group.webtraffic.name]
    user_data = <<-EOL
    #!/bin/bash
    sudo yum update
    sudo yum install -y httpd
    sudo systemctl start httpd
    sudo systemctl enable httpd
    echo "<h1>Hello from Terraform</h1>" | sudo tee /var/www/html/index.html
        EOL
        tags = {
            Name = "Web Server"
        }
    }


output "dbprivate" {
    value = aws_instance.DB.private_ip
}
output "webpublic" {
    value = aws_instance.wevserver.public_ip
}

variable "ingressrules" {
    type = list(number)
    default = [80, 443]
}

variable "egressrules" {
    type = list(number)
    default = [80, 443]
}

resource "aws_eip" "myelasticip" {
    instance = aws_instance.wevserver.id
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
        cidr_blocks = ["0.0.0.0/0"]
        }
    }
    
    dynamic "egress" {
        iterator = port
        for_each = var.egressrules
        content {
        from_port = port.value
        to_port = port.value
        protocol = "TCP"
        cidr_blocks = ["0.0.0.0/0"]
        }
    }
}

output "eipserver" {
    value = aws_eip.myelasticip.public_ip
}