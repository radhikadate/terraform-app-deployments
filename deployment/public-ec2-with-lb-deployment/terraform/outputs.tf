output "alb_dns_name" {
  description = "DNS name of the Application Load Balancer"
  value       = module.application_alb.alb_dns_name
}

output "instance_ids" {
  description = "List of EC2 instance IDs"
  value       = module.application_compute.instance_ids
}
