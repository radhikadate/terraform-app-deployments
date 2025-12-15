# Terraform App Deployments

Multiple approaches to deploying applications on AWS using Terraform.

## Project Structure

```
terraform-app-deployments/
├── hello-world-app/          # Sample Flask application
└── using-ec2-userdata-script/ # EC2 deployment with user data
```

## Deployment Methods

### 1. Using EC2 with User Data Script
Deploy Flask app on EC2 instance using user data for bootstrapping.

**Location:** `using-ec2-userdata-script/`

**Features:**
- Modular Terraform structure (network, compute, dns)
- VPC with public/private subnets
- Security groups for SSH and HTTP access
- EC2 instance with Amazon Linux 2

**Usage:**
```bash
cd using-ec2-userdata-script/
terraform init
terraform plan
terraform apply
```

## Sample Application

Simple Flask "Hello World" app located in `hello-world-app/`

**Run locally:**
```bash
cd hello-world-app/
pip install -r requirements.txt
python app.py
```

Access at `http://localhost:4000`

## Prerequisites

- Terraform >= 1.0
- AWS CLI configured
- AWS account with appropriate permissions
- EC2 Key Pair created

## Configuration

Set required variables in `terraform.tfvars`:
```hcl
environment = "dev"
key_name    = "your-key-pair-name"
```

## Future Deployment Methods

- Using ECS/Fargate
- Using Lambda
- Using Elastic Beanstalk
- Using EKS (Kubernetes)
