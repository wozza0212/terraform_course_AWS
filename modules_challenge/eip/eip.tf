variable "instance_id" {
  type = string
}

resource "aws_eip" "myelasticip" {
    instance = var.instance_id
}

output "eipserver" {
    value = aws_eip.myelasticip.public_ip
}