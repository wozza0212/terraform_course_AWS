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