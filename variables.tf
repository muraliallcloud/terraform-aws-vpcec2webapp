####################################
# Generic Variables
####################################

variable "region" {
  description = "Region in which AWS resources to be created"
  type = string
  default = null
}

variable "profile" {
  description = "AWS Profile to be used to create resources"
  type = string
  default = null
}

variable "application_name" {
  description = "Application Name used for prefix of resource names"
  type = string
  default = null
}

variable "owners" {
  description = "Owners Name used for prefix of resource names"
  type = string
  default = null
}

variable "azs" {
  description = "AZ Groups List"
  type    = list(any)
  default = null
}

####################################
# For Module
####################################

variable "create_vpc_igw_rt_sn" {
  description = ""
  type = bool
  default = null
}

variable "create_public_sg" {
  description = ""
  type = bool
  default = null
}

variable "create_private_sg" {
  description = ""
  type = bool
  default = null
}

####################################
# VPC Variables
####################################

variable "vpc_cidr_block" {
  description = "CIDR Block to be assigned for VPC"
  type    = string
  default = null
}

variable "all_cidr_block" {
  description = "CIDR Block with all IPs"
  type    = list(any)
  default = null
}

variable "igw_cidr_block" {
  description = "IGW CIDR Block"
  type    = string
  default = null
}

variable "sn_1a" {
  description = "CIDR Block to be assigned for Subnet"
  type    = string
  default = null
}

variable "sn_2a" {
  description = "CIDR Block to be assigned for Subnet"
  type    = string
  default = null
}

variable "sn_1b" {
  description = "CIDR Block to be assigned for Subnet"
  type    = string
  default = null
}

variable "sn_2b" {
  description = "CIDR Block to be assigned for Subnet"
  type    = string
  default = null
}


####################################
# Security Group Variables
####################################

variable "ingress_public_sg_ports" {
  description = "Public Security Group Ports"
  type    = list(any)
  default = null
}

variable "ingress_private_sg_ports" {
  description = "Private Security Group Ports"
  type    = list(any)
  default = null
}


####################################
# EC2 Variables
####################################

variable "linux_ami" {
  type = string
  description = ""
  default     = null
}

variable "windows_ami" {
  type = string
  description = ""
  default   = null
}

variable "instance_type" {
  type = string
  description = ""
  default = null
}

variable "publicip" {
  type = bool
  description = ""
  default      = null
}

variable "keyname" {
  type = string
  description = ""
  default       = null
}

variable "linuxwebsetupscript_src" {
  type = string
  description = ""
  default = null
}

variable "linuxwebsetupscript_dest" {
  type = string
  description = ""
  default = null
}

variable "create_ec2_linux" {
  type = bool
  description = ""
  default = null
}

variable "create_ec2_windows" {
  type = bool
  description = ""
  default = null
}

variable "ec2_instances_count" {
  type = number
  description = "Number of EC2 Instances to be created. Hint- Should be less than 3."
  default = null
  validation {
    condition = var.ec2_instances_count <3
    error_message = "The Number of Instances to be created should be less than 3."
}
}

variable "ec2_instance_platform" {
  type = string
  description = "Enter the EC2 Instance platform. Hint- linux / windows ."
  default = null
}


