AWS VPC SG EC2 Creation Terraform module

Terraform module which creates VPC SG EC2 resources on AWS.

Usage Example:<br/>

module "vpcec2webapp" {<br/>
  source  = "muraliallcloud/vpcec2webapp/aws"<br/>
  version = "0.0.2"<br/><br/>

  #Generic configuration<br/>
  region = "ap-south-1"<br/>
  profile = "default"<br/>
  application_name = "brickspay"<br/>
  owners = "Infra"<br/>
  azs = ["ap-south-1a", "ap-south-1b", "ap-south-1c"]<br/>

  #Resource Creation Configuration<br/>
  create_vpc_igw_rt_sn = true<br/>
  create_public_sg = true<br/>
  create_private_sg = true<br/>
  create_ec2_linux = true<br/>
  create_ec2_windows = false<br/>

  #VPC Configuration<br/>
  vpc_cidr_block = "172.25.0.0/16"<br/>
  all_cidr_block = ["0.0.0.0/0"]<br/>
  igw_cidr_block = "0.0.0.0/0"<br/>
  sn_1a = "172.25.1.0/28"<br/>
  sn_2a = "172.25.2.0/28"<br/>
  sn_1b = "172.25.3.0/28"<br/>
  sn_2b = "172.25.4.0/28"<br/>

  #Security Group Configuration
  ingress_public_sg_ports = ["22", "443", "80", "3389"]
  ingress_private_sg_ports = ["22","80"]

  #EC2 Configuration
  linux_ami     = "ami-079b5e5b3971bd10d"
  windows_ami   = "ami-09ed03e97033b6d21"
  instance_type = "t2.micro"
  publicip      = true
  keyname       = "bookz-privatekey"
  linuxwebsetupscript_src = "linuxwebsetup.sh"
  linuxwebsetupscript_dest = "/tmp/linuxwebsetup.sh"
  ec2_instance_platform = "linux"
  #ec2_instances_count = 1

}
