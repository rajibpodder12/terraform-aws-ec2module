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


output "ami_id" {
  value = data.aws_ami.ami_id.id
}

output "own_public_ip" {
  value = chomp(data.http.ownip.response_body)
}

output "http_url" {
  value = <<-EOT
    httpd url: http://${aws_instance.ec2.public_ip}
    EOT
}
