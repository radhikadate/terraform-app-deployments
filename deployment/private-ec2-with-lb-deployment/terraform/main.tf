module "application_network" {
  source      = "../../common-modules/network-multi-az"
  cidr_block  = "10.0.0.0/16"
  environment = var.environment
}

resource "aws_security_group" "alb_sg" {
  name_prefix = "${var.environment}-alb-sg"
  vpc_id      = module.application_network.vpc_id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.environment}-alb-sg"
  }
}

module "application_compute" {
  source                 = "../../common-modules/compute-multi-instance"
  environment            = var.environment
  vpc_id                 = module.application_network.vpc_id
  private_subnet_ids     = module.application_network.private_subnet_ids
  key_name               = var.key_name
  alb_security_group_id  = aws_security_group.alb_sg.id
}

module "application_alb" {
  source              = "../../common-modules/alb"
  environment         = var.environment
  vpc_id              = module.application_network.vpc_id
  public_subnet_ids   = module.application_network.public_subnet_ids
  target_instance_ids = module.application_compute.instance_ids
  alb_security_group_id = aws_security_group.alb_sg.id
}
