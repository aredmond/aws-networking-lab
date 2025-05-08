output "instance_id" {
  description = "ID of the EC2 instance"
  value       = aws_instance.instance.id
}

output "instance_private_ip" {
  description = "Private IP address of the EC2 instance"
  value       = aws_instance.instance.private_ip
}

output "instance_public_ip" {
  description = "Public IP address of the EC2 instance"
  value       = aws_instance.instance.public_ip
}

output "security_group_id" {
  description = "ID of the security group"
  value       = aws_security_group.instance_sg.id
}

output "ssh_private_key" {
  description = "Private key for SSH access"
  value       = tls_private_key.ssh_key.private_key_pem
  sensitive   = true
}

output "iam_role_arn" {
  description = "ARN of the IAM role"
  value       = aws_iam_role.instance_role.arn
} 