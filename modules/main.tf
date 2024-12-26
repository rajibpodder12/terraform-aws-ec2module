resource "aws_instance" "ec2" {
    ami = data.aws_ami.ami_id.id
    instance_type = var.instance_type
    user_data = file("./userdata.sh")
    tags = {
        "Name" = "ec2"
        "ManagedBy" = "terraform"
    }
}