terraform {
  backend "s3" {
    
  }
}

provider "aws"{
    region = "eu-west-2"
}
 
variable "vpc_id" {
    description = "Existing VPC Id"
    type = string
}
variable "subnet_id" {
    description = "Existing Subnet Id"
    type = string
}
variable "ami_id" {
    description = "Existing AMI Id"
    type = string
}
variable "security_group_id" {
    description = "Existing SG Id"
    type = string
}
variable "instance_type" {
    description = "Type of Instance"
    type = string
    default = "t3.micro"
}
variable "env" {
    description = "Environment of the deployment"
    type = string
    default = "dev"
}
variable "key_pair_name" {
    description = "Key Value Pair Name"
    type = string  
}
 
 
resource "aws_instance" "shivakumar-terraform-instance" {

    ami = var.ami_id
    instance_type = var.instance_type
    subnet_id = var.subnet_id
    vpc_security_group_ids = [var.security_group_id]
    key_name = var.key_pair_name
    associate_public_ip_address = true
    tags = {
        Name = "Shivakumar ${var.env} Instance"
        "Company" = "Torry Harris"
    }

}

output "public_ipv4_address" {
    description = "Public IPv4 Address"
    value = aws_instance.shivakumar-terraform-instance.public_ip
}