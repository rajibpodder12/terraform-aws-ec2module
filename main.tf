terraform {
    required_providers {
      aws = {
        source = "hashicorp/aws"
        version = "~> 5.0"
      }
    }
}

provider "aws" {
    region = var.region
}

data "aws_ami" "ami_id" {
    owners = ["amazon"]
    most_recent = true
    filter {
      name = "name"
      values = [ "amz2-ami-hvm-*" ]
    }
    filter {
      name = "virtualization-type"
      values = ["hvm"]
    }
    filter {
        name = "root-device-type"
        values = ["ebs"]
    }
    filter {
        name ="architecture"
        values = ["x86_64"]
    }
}

resource "aws_instance" "ec2" {
    ami = data.aws_ami.ami_id.id
    instance_type = var.instance_type
    user_data = file("./userdata.sh")
    tags = {
        "Name" = "ec2"
        "ManagedBy" = "terraform"
    }
}