provider "aws" {
    region = "eu-west-1"
}


module "ec2module" {
    source = "./ec2"
    ec2name = "Module instance"
}
output "module_output" {
    value = module.ec2module.module_instance_id

}