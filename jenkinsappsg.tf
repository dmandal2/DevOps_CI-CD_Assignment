module "jenkins_app_sg" {
  source = "terraform-aws-modules/security-group/aws"

  name        = "Terraform"
  description = "Security group for port ssh open to everyone"
  vpc_id      = module.vpc.vpc_id

  ingress_with_cidr_blocks = [
    {
      from_port   = 0
      to_port     = 65535
      protocol    = "-1"
      description = "all-ports"
      cidr_blocks = "0.0.0.0/0"
    },
]
 egress_rules = [
 "all-all"]
 egress_cidr_blocks = ["0.0.0.0/0"]
}
module "ec2_instance1" {
  source  = "terraform-aws-modules/ec2-instance/aws"

  name = "Jenkins-instance"

  ami = "ami-053b0d53c279acc90"
  instance_type          = "t2.micro"
  key_name               = "Assignment"
  monitoring             = true
  vpc_security_group_ids = [module.jenkins_app_sg.security_group_id]
  subnet_id              = module.vpc.private_subnets[0]


  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}
module "ec2_instance2" {
  source  = "terraform-aws-modules/ec2-instance/aws"

  name = "apps-instance"

  ami = "ami-053b0d53c279acc90"
  instance_type          = "t2.micro"
  key_name               = "Assignment"
  monitoring             = true
  vpc_security_group_ids = [module.jenkins_app_sg.security_group_id]
  subnet_id              = module.vpc.private_subnets[1]


  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}
