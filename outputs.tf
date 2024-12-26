output "ec2_public_ip" {
  value       = aws_instance.ec2.public_ip
  description = "output public ip of ec2 instance"
}

output "ec2_instance_id" {
  value       = aws_instance.ec2.id
  description = "output ec2 instance id"
}


output "ec2_instance_private_ip" {
  value       = aws_instance.ec2.private_ip
  description = "output ec2 instance private ip"
}