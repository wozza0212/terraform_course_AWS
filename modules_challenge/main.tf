provider "aws" {
    region = "eu-west-1"
}

module "db_server" {
    source = "./db_Server"
    myAmiId = "ami-0ce8c2b29fcc8a346"
    instanceType = "t2.micro"
}

module "web_server" {
    source = "./web_server"
    myAmiId =  "ami-0ce8c2b29fcc8a346"
    instanceType = "t2.micro"
}

output "dbprivate" {
    value = module.db_server.db_ip
}
output "webpublic" {
    value = module.web_server.eip_server
}

output "public_ip" {
    value = module.web_server.public_ip
}