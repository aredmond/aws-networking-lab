output "instance_id" {
  description = "ID of the EC2 instance"
  value       = module.bastion.instance_id
}

output "instance_private_ip" {
  description = "Private IP address of the EC2 instance"
  value       = module.bastion.instance_private_ip
}

output "instance_public_ip" {
  description = "Public IP address of the EC2 instance"
  value       = module.bastion.instance_public_ip
}

output "security_group_id" {
  description = "ID of the security group"
  value       = module.bastion.security_group_id
}

output "ssh_private_key" {
  description = "Private key for SSH access"
  value       = module.bastion.ssh_private_key
  sensitive   = true
}

output "iam_role_arn" {
  description = "ARN of the IAM role"
  value       = module.bastion.iam_role_arn
}