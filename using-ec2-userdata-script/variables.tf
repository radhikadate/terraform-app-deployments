variable "environment" {
  description = "Environment name (dev, staging, prod)"
  type        = string
  default     = "dev"
}

variable "key_name" {
  description = "EC2 Key Pair name"
  type        = string
}