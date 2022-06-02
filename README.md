AWS VPC SG EC2 Terraform module

Terraform module which creates VPC SG EC2 resources on AWS.

Usage:

module "vpc-sg-ec2" {
  source = "terraform-aws-modules/vpc-sg-ec2"
  application_name = "brickspay"
  
  }
}