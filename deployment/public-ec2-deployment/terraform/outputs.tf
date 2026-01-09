output "instance_public_ip" {
  description = "Public IP address of the EC2 instance"
  value       = module.application_compute.instance_public_ip
}
