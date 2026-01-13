output "alb_dns_name" {
  description = "DNS name of the Application Load Balancer"
  value       = aws_lb.app_lb.dns_name
}

output "asg_name" {
  description = "Name of the Auto Scaling Group"
  value       = module.application_asg.asg_name
}
