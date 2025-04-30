variable "myAmiId" {
    type = string
    # default = "ami-0ce8c2b29fcc8a346"
}

variable "instanceType" {
    type = string
    # default = "t2.micro"
}

resource "aws_instance" "DB" {
    ami = var.myAmiId
    instance_type = var.instanceType
    tags = {
        Name = "DB Server"
    }
}

output "db_ip" {
    value = aws_instance.DB.private_ip
}