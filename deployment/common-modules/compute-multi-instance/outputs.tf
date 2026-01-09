output "instance_ids" {
  description = "List of EC2 instance IDs"
  value       = aws_instance.app_servers[*].id
}

output "instance_private_ips" {
  description = "List of private IP addresses"
  value       = aws_instance.app_servers[*].private_ip
}

output "security_group_id" {
  description = "Security group ID of EC2 instances"
  value       = aws_security_group.ec2_sg.id
}
