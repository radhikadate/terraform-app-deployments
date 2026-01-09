This project demonstrates an improvement over 'public-ec2-with-lb- deployment' by deploying the application on two ec2 instances created in the private subnet (one in each az) and adding a load balancer in front of the ec2 instances. By deplying in proviate instances we are improving the **security posture** of the application.

The project sets up a vpc with both public and private subnets. It creates two ec2 instance in the private subnet with a security group allowing connection on port 80 from "Your IP". It then creates a load balancer in the public subnet and a target group to route traffic to the two instances.

The infrastructure is provisioned using Terraform.

The application code deployment is done through ec2 user data.

The actual deployment and testing to check whether the application is deplooyed correctly is done using github actions.
