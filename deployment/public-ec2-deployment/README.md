This project demonstrates the simplest deployment for the hello world app. 

The project sets up a vpc with both public and private subnets. It creates an ec2 instance in the public subnet with a security group allowing connection on port 80 from "Your IP". 

The infrastructure is provisioned using Terraform.

The application code deployment is done through ec2 user data.

The actual deployment and testing to check whether the application is deplooyed correctly is done using github actions.
