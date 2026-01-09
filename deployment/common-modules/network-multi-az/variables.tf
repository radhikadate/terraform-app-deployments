variable "cidr_block" {
  description = "The CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "project" {
  description = "The name of the project"
  type        = string
  default     = "ec2-alb"
}

variable "environment" {
  description = "The environment (dev, test, prod)"
  type        = string
}

variable "availability_zones" {
  description = "List of availability zones"
  type        = list(string)
  default     = ["ap-south-1a", "ap-south-1b"]
}
