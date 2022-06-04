**AWS - VPC / IGW / RT / SN / SG / EC2 Creations using this Terraform module**

This Terraform module can be used to create below resources:<br/>
> VPC<br/>
> Internet Gateway<br/>
> Route Tables<br/>
> Subnets<br/>
> Security Groups<br/>
> EC2 Instances<br/>

<br/>

**Usage Example:**

```rb
module "vpcec2webapp" {
  source  = "muraliallcloud/vpcec2webapp/aws"
  version = "~> 0.0.4"

  # Generic configuration
  region = "ap-south-1"
  profile = "default"
  application_name = "brickspay"
  owners = "Infra"
  azs = ["ap-south-1a", "ap-south-1b", "ap-south-1c"]

  # Resource Creation Configuration
  create_vpc_igw_rt_sn = true
  create_public_sg = true
  create_private_sg = true
  create_ec2_linux = true
  create_ec2_windows = false

  # VPC Configuration
  vpc_cidr_block = "172.25.0.0/16"
  all_cidr_block = ["0.0.0.0/0"]
  igw_cidr_block = "0.0.0.0/0"
  sn_1a = "172.25.1.0/28"
  sn_2a = "172.25.2.0/28"
  sn_1b = "172.25.3.0/28"
  sn_2b = "172.25.4.0/28"

  # Security Group Configuration
  ingress_public_sg_ports = ["22", "443", "80", "3389"]
  ingress_private_sg_ports = ["22","80"]

  # EC2 Configuration
  linux_ami     = "ami-079b5e5b3971bd10d"
  windows_ami   = "ami-09ed03e97033b6d21"
  instance_type = "t2.micro"
  publicip      = true
  keyname       = "bookz-privatekey"
  linux_userdata_script = "linuxwebsetup.sh"
  linuxwebsetupscript_dest = "/tmp/linuxwebsetup.sh"
  windows_userdata_script = "windbsetup.txt"
  ec2_instance_platform = "linux"
  ec2_instances_count = 1

  # Load Balancer Configuration
  create_alb = true

}
```

**Note:**<br/>
When using user_data parameter for EC2 Instances, make sure to create respective files in your terrform working directory.

**Info:**<br/>
The Scripts\files provided here are for personal testing purpose without any Warranty of any Kind.