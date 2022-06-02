####################################
# Providers
####################################

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.13.0"
    }   
  }
}

provider "aws" {
  region = var.region
  profile = var.profile
  #access_key = var.access_key
  #secret_key = var.secret_key
}

####################################
# Local Values
####################################

locals {
  owners = var.owners
  application_name = var.application_name
  name_conv = "${var.owners}-${var.application_name}"
  common_tags = {
    Owner = local.owners
    Application = local.application_name
  }
} 


####################################
# VPC
####################################

resource "aws_vpc" "vpc" {
  cidr_block = var.vpc_cidr_block
  tags = {
    Name = "${local.name_conv}-vpc"
  }
  enable_dns_hostnames = true

  count = var.create_vpc_igw_rt_sn ? 1:0
}

####################################
# Internet gateway
####################################

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc[count.index].id
  tags = {
    Name = "${local.name_conv}-igw"
  }

  count = var.create_vpc_igw_rt_sn ? 1:0
}

####################################
# Route Table
####################################

resource "aws_route_table" "rt_tbl" {
  vpc_id = aws_vpc.vpc[count.index].id

  route {
    cidr_block = var.igw_cidr_block
    #cidr_block = toset(var.all_cidr_block)
    #cidr_block = toset("${split(",", join(",", var.all_cidr_block))}")
    gateway_id = aws_internet_gateway.igw[count.index].id
  }

  tags = {
    Name = "${local.name_conv}-rt"
  }

  count = var.create_vpc_igw_rt_sn ? 1:0
}

####################################
# Subnets
####################################

resource "aws_subnet" "subnet1a" {
  vpc_id            = aws_vpc.vpc[count.index].id
  cidr_block        = var.sn_1a
  availability_zone = var.azs[0]
  map_public_ip_on_launch = true

  tags = {
    Name = "${local.name_conv}-sn1a"
  }

  count = var.create_vpc_igw_rt_sn && length(var.azs)>1 ? 1:0
}

resource "aws_subnet" "subnet2a" {
  vpc_id            = aws_vpc.vpc[count.index].id
  cidr_block        = var.sn_2a
  availability_zone = var.azs[1]
  map_public_ip_on_launch = true

  tags = {
    Name = "${local.name_conv}-sn2a"
  }

  count = var.create_vpc_igw_rt_sn && length(var.azs)>1 ? 1:0
}

resource "aws_subnet" "subnet1b" {
  vpc_id            = aws_vpc.vpc[count.index].id
  cidr_block        = var.sn_1b
  availability_zone = var.azs[0]
  map_public_ip_on_launch = true

  tags = {
    Name = "${local.name_conv}-sn1b"
  }

  count = var.create_vpc_igw_rt_sn && length(var.azs)>1 ? 1:0
}

resource "aws_subnet" "subnet2b" {
  vpc_id            = aws_vpc.vpc[count.index].id
  cidr_block        = var.sn_2b
  availability_zone = var.azs[1]
  map_public_ip_on_launch = true

  tags = {
    Name = "${local.name_conv}-sn2b"
  }

  count = var.create_vpc_igw_rt_sn && length(var.azs)>1 ? 1:0
}

####################################
# Route table Subnet Association
####################################

resource "aws_route_table_association" "subnet1a_rt" {
  subnet_id      = aws_subnet.subnet1a[count.index].id
  route_table_id = aws_route_table.rt_tbl[count.index].id
  count = var.create_vpc_igw_rt_sn ? 1:0
}

resource "aws_route_table_association" "subnet2a_rt" {
  subnet_id      = aws_subnet.subnet2a[count.index].id
  route_table_id = aws_route_table.rt_tbl[count.index].id
  count = var.create_vpc_igw_rt_sn ? 1:0
}

resource "aws_route_table_association" "subnet1b_rt" {
  subnet_id      = aws_subnet.subnet1b[count.index].id
  route_table_id = aws_route_table.rt_tbl[count.index].id
  count = var.create_vpc_igw_rt_sn ? 1:0
}

resource "aws_route_table_association" "subnet2b_rt" {
  subnet_id      = aws_subnet.subnet2b[count.index].id
  route_table_id = aws_route_table.rt_tbl[count.index].id
  count = var.create_vpc_igw_rt_sn ? 1:0
}

####################################
# Public Security Group
####################################

resource "aws_security_group" "public_sg" {
  name        = "public_sg"
  description = "screenz security groups"
  vpc_id      = aws_vpc.vpc[0].id

  dynamic "ingress" {
    for_each = var.ingress_public_sg_ports
    iterator = portnmb
    content {
      from_port   = portnmb.value
      to_port     = portnmb.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
      #ipv6_cidr_blocks = [aws_vpc.screenz.ipv6_cidr_block]
    }
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    #ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "${local.name_conv}-public-sg"
  }

  count = var.create_vpc_igw_rt_sn && var.create_public_sg ? 1:0
}

####################################
# Private Security Group
####################################

resource "aws_security_group" "private_sg" {
  name        = "private_sg"
  description = "screenz security groups"
  vpc_id      = aws_vpc.vpc[0].id

  dynamic "ingress" {
    for_each = var.ingress_private_sg_ports
    iterator = portnmb
    content {
      from_port   = portnmb.value
      to_port     = portnmb.value
      protocol    = "tcp"
      cidr_blocks = "${split(",", join(",", var.all_cidr_block))}"
      #ipv6_cidr_blocks = [aws_vpc.screenz.ipv6_cidr_block]
    }
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = "${split(",", join(",", var.all_cidr_block))}"
    #ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "${local.name_conv}-private-sg"
  }

  count = var.create_vpc_igw_rt_sn && var.create_private_sg ? 1:0
}

####################################
# EC2 Linux Instance
####################################

resource "aws_instance" "ec2_linux" {
  ami           = var.linux_ami
  instance_type = var.instance_type
  subnet_id     = aws_subnet.subnet1a[0].id
  associate_public_ip_address = var.publicip
  key_name               = var.keyname
  vpc_security_group_ids = [aws_security_group.public_sg[0].id]
  
  tags = {
    Name = "${local.name_conv}-web${count.index}"

  }

  count = var.sn_1a != null && var.create_ec2_linux && var.ec2_instance_platform == "linux" ? var.ec2_instances_count : 0

  #user_data = "${file("linuxwebsetup.sh")}"

/*
  connection {
     type = "ssh"
     user = "ec2-user"
     #private_key = file("../../../../EC2 Keys/bookzprivatekey.pem")
     host = self.public_ip
  }

  provisioner "file" {
    source = lookup(var.ec2_prpts, "linuxwebsetupscript_src")
    destination = lookup(var.ec2_prpts, "linuxwebsetupscript_dest")
  }
  provisioner "remote-exec" {
    inline = [
      "sudo chmod +x /tmp/linuxwebsetup.sh",
      "sudo sh /tmp/linuxwebsetup.sh"
    ]
  }
*/

}

####################################
# EC2 Windows Instance
####################################

resource "aws_instance" "ec2_windows" {
  ami           = var.windows_ami
  instance_type = var.instance_type
  subnet_id     = aws_subnet.subnet2a[0].id
  associate_public_ip_address = var.publicip
  key_name               = var.keyname
  vpc_security_group_ids = [aws_security_group.public_sg[0].id]

  tags = {
    Name = "${local.name_conv}-db${count.index}"

  }

  count = var.sn_2a != null && var.create_ec2_windows && var.ec2_instance_platform == "windows" ? var.ec2_instances_count : 0

  #user_data = "${file("windbsetup.txt")}"

}

