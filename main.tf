terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.region
}

/*
data "aws_ami" "amzn2" {
  most_recent = true
  owners      = ["amazon"]
  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
  filter {
    name   = "architecture"
    values = ["x86_64"]
  }
  filter {
    name   = "name"
    values = ["amzn2-ami-hvm*"]
  }
}
*/

data "aws_subnets" "this" {

  filter {
    name   = "map-public-ip-on-launch"
    values = ["true"]
  }

}

data "aws_ami" "ami_id" {
  most_recent = "true"
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-2023*"]
  }
  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
  filter {
    name   = "architecture"
    values = ["x86_64"]
  }

}
data "http" "ownip" {
  url = "https://ipv4.icanhazip.com"
}

#sg to allow communication only from machine public ip address
resource "aws_security_group" "ec2sg" {
  name        = "ec2sg"
  description = "allow ssh connection only from own laptop ip address."
  ingress {
    from_port   = "0"
    to_port     = "0"
    protocol    = "-1"
    cidr_blocks = ["${chomp(data.http.ownip.response_body)}/32"]
  }
  egress {
    from_port   = "0"
    to_port     = "0"
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "ec2sg"
  }
}


resource "aws_iam_role" "iam_role" {
  name               = "ec2-role"
  assume_role_policy = data.aws_iam_policy_document.iam_role_policy_document.json
}

resource "aws_iam_role_policy_attachment" "this" {
  role       = aws_iam_role.iam_role.name
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}

data "aws_iam_policy_document" "iam_role_policy_document" {
  statement {
    actions = ["sts:AssumeRole"]
    effect  = "Allow"
    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

resource "aws_iam_instance_profile" "ec2profile" {
  name = "ec2profile"
  role = aws_iam_role.iam_role.name
}

resource "aws_instance" "ec2" {
  ami                    = data.aws_ami.ami_id.id
  instance_type          = var.instance_type
  user_data              = file("${path.module}/userdata.sh")
  vpc_security_group_ids = [aws_security_group.ec2sg.id]
  iam_instance_profile   = aws_iam_instance_profile.ec2profile.name
  tags = {
    "Name"      = "ec2"
    "ManagedBy" = "terraform"
  }
}
