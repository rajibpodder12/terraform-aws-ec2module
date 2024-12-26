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