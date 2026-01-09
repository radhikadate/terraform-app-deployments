This project demonstrates an improvement over 'private-ec2-with-lb- deployment' by deploying the application on ec2 instanfces in an auto scaling group with a minimum of to ec2 instances (one in each az) in the private subnet and adding a load balancer in front of the ec2 instances. By using auto scaling instances we are improving the **fault tolerance** of the application.

The project sets up a vpc with both public and private subnets. It creates a lauch template and auto scaling group of ec2 instance in the private subnet with a security group allowing connection on port 80 from "Your IP". It then creates a load balancer in the public subnet and a target group to route traffic to the instances in the auto scaling group.

The infrastructure is provisioned using Terraform.

The application code deployment is done through ec2 user data.

The actual deployment and testing to check whether the application is deplooyed correctly is done using github actions.
