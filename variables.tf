####################################
# Generic Variables
####################################

variable "region" {
  description = "Region in which AWS resources to be created"
  type = string
  default = "ap-south-1"
}

#variable "access_key" {}
#variable "secret_key" {}

variable "profile" {
  description = "AWS Profile to be used to create resources"
  type = string
  default = "default"
}

variable "application_name" {
  description = "Application Name used for prefix of resource names"
  type = string
  default = "screenz"
}

variable "owners" {
  description = "Owners Name used for prefix of resource names"
  type = string
  default = "Infra"
}

variable "azs" {
  description = "AZ Groups List"
  type    = list(any)
  default = ["ap-south-1a", "ap-south-1b", "ap-south-1c"]
}

####################################
# For Module
####################################

variable "create_vpc_igw_rt_sn" {
  description = ""
  type = bool
  default = true
}

variable "create_public_sg" {
  description = ""
  type = bool
  default = true
}

variable "create_private_sg" {
  description = ""
  type = bool
  default = true
}

####################################
# VPC Variables
####################################

variable "vpc_cidr_block" {
  description = "CIDR Block to be assigned for VPC"
  type    = string
  default = "172.25.0.0/16"
}

variable "all_cidr_block" {
  description = "CIDR Block with all IPs"
  type    = list(any)
  default = ["0.0.0.0/0"]
}

variable "igw_cidr_block" {
  description = "IGW CIDR Block"
  type    = string
  default = "0.0.0.0/0"
}

variable "sn_1a" {
  description = "CIDR Block to be assigned for Subnet"
  type    = string
  default = "172.25.1.0/28"
}

variable "sn_2a" {
  description = "CIDR Block to be assigned for Subnet"
  type    = string
  default = "172.25.2.0/28"
}

variable "sn_1b" {
  description = "CIDR Block to be assigned for Subnet"
  type    = string
  default = "172.25.3.0/28"
}

variable "sn_2b" {
  description = "CIDR Block to be assigned for Subnet"
  type    = string
  default = "172.25.4.0/28"
}


####################################
# Security Group Variables
####################################

variable "ingress_public_sg_ports" {
  description = "Public Security Group Ports"
  type    = list(any)
  default = ["22", "443", "80", "3389"]
}

variable "ingress_private_sg_ports" {
  description = "Private Security Group Ports"
  type    = list(any)
  default = ["22","80"]
}


####################################
# EC2 Variables
####################################

variable "linux_ami" {
  type = string
  description = ""
  default     = "ami-079b5e5b3971bd10d"
}

variable "windows_ami" {
  type = string
  description = ""
  default   = "ami-09ed03e97033b6d21"
}

variable "instance_type" {
  type = string
  description = ""
  default = "t2.micro"
}

variable "publicip" {
  type = bool
  description = ""
  default      = true
}

variable "keyname" {
  type = string
  description = ""
  default       = "bookz-privatekey"
}

variable "linuxwebsetupscript_src" {
  type = string
  description = ""
  default = "linuxwebsetup.sh"
}

variable "linuxwebsetupscript_dest" {
  type = string
  description = ""
  default = "/tmp/linuxwebsetup.sh"
}

variable "create_ec2_linux" {
  type = bool
  description = ""
  default = true
}

variable "create_ec2_windows" {
  type = bool
  description = ""
  default = false
}

variable "ec2_instances_count" {
  type = number
  description = "Number of EC2 Instances to be created. Hint- Should be less than 3."
  default = 1
  validation {
    condition = var.ec2_instances_count <3
    error_message = "The Number of Instances to be created should be less than 3."
}
}

variable "ec2_instance_platform" {
  type = string
  description = "Enter the EC2 Instance platform. Hint- linux / windows ."
  default = "linux"
}


####################################
# EC2 Variables
####################################

