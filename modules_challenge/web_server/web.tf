variable "myAmiId" {
    type = string
    # default = "ami-0ce8c2b29fcc8a346"
}

variable "instanceType" {
    type = string
    # default = "t2.micro"
}

module "eip" {
    source = "../eip"
    instance_id = aws_instance.webserver.id
}
module "security_group" {
    source = "../sg"
    ingressrules = [80, 443]
    egressrules = [80, 443]
}

resource "aws_instance" "webserver" {
    ami = var.myAmiId
    instance_type = var.instanceType
    security_groups = [module.security_group.sg_name]
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

output "eip_server" {
    value = module.eip.eipserver
}

output "public_ip" {
    value = aws_instance.webserver.public_ip
}