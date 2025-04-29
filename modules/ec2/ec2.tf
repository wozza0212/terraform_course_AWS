variable "myAmiId" {
    type = string
    default = "ami-0ce8c2b29fcc8a346"
}

variable "ec2name" {
    type = string
}

variable "instanceType" {
    type = string
    default = "t2.micro"
}

resource "aws_instance" "moduleinstance" {
    ami = var.myAmiId
    instance_type = var.instanceType
    tags = {
        Name = var.ec2name
    }
}

output "module_instance_id" {
    value = aws_instance.moduleinstance.id
}
