AWS VPC SG EC2 Terraform module

Terraform module which creates VPC SG EC2 resources on AWS.

Usage:

module "vpcec2webapp" {
  source = "terraform-aws-modules/vpcec2webapp/aws"
  application_name = "brickspay"
  
  }
}