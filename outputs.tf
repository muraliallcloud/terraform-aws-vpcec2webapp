output "vpcname-cidrblock" {
  value = "${aws_vpc.vpc[0].tags.Name}-${aws_vpc.vpc[0].cidr_block}"
}

output "subnet1aname-cidrblock" {
  value = "${aws_subnet.subnet1a[0].tags.Name}-${aws_subnet.subnet1a[0].cidr_block}"
}

output "subnet2aname-cidrblock" {
  value = "${aws_subnet.subnet1b[0].tags.Name}-${aws_subnet.subnet1b[0].cidr_block}"
}

output "subnet1bname-cidrblock" {
  value = "${aws_subnet.subnet2a[0].tags.Name}-${aws_subnet.subnet2a[0].cidr_block}"
}

output "subnet2bname-cidrblock" {
  value = "${aws_subnet.subnet2b[0].tags.Name}-${aws_subnet.subnet2b[0].cidr_block}"
}

output "public_sg_ports" {
  description = "Public Security Groups Ports"
  value = toset([for sg in aws_security_group.public_sg.*.ingress: sg.*.from_port])
}

output "private_sg_ports" {
  description = "Private Security Groups Ports"
  value = toset([for sg in aws_security_group.private_sg.*.ingress: sg.*.from_port])
}

output "linux_public_ips" {
  value = toset([for instance in aws_instance.ec2_linux: "${instance.tags.Name}-${instance.instance_type}-${instance.subnet_id}-${instance.availability_zone}-${instance.public_ip}"])
} 

output "windows_public_ips" {
  value = toset([for instance in aws_instance.ec2_windows: "${instance.tags.Name}-${instance.instance_type}-${instance.subnet_id}-${instance.availability_zone}-${instance.public_ip}"])
} 

output "alb_subnets" {
    value = toset([for alb_info in aws_lb.alb: "${alb_info.name}-toset(${alb_info.subnets})"])
}

output "alb_securitygroups" {
    value = toset([for alb_info in aws_lb.alb: "${alb_info.name}-toset(${alb_info.security_groups})"])
}