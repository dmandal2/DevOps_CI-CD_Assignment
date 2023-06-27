module "bastion_sg" {
  source = "terraform-aws-modules/security-group/aws"

  name        = "Terraform"
  description = "Security group for port ssh open to everyone"
  vpc_id      = module.vpc.vpc_id

  ingress_with_cidr_blocks = [
    {
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      description = "User-service ports"
      cidr_blocks = "0.0.0.0/0"
    },
]
 egress_rules = [
 "all-all"]
 egress_cidr_blocks = ["0.0.0.0/0"]
}

module "ec2_instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"

  name = "Bastion"

  ami = "ami-053b0d53c279acc90"
  instance_type          = "t2.micro"
  key_name               = "Assignment"
  monitoring             = true
  vpc_security_group_ids = [module.bastion_sg.security_group_id]
  subnet_id              = module.vpc.public_subnets[0]
  associate_public_ip_address = true


  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}
