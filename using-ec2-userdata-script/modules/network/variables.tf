variable "cidr_block" {
  description = "The CIDR block for the vpc"
  type        = string
  default     = "10.0.0.0/16"
}

variable "project" {
  description = "the name of the project for which network is being created"
  type = string
  default = "dev"
}

variable "environment" {
 description = "the environment in which the network is being created" 
 type = string
 validation {
  condition = contains(["dev", "test", "prod"], var.environment)
  error_message = "Environment must be dev, staging, or prod."
   
 }
 
}