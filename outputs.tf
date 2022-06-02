output "linux_public_ips" {
  value = toset([for instance in aws_instance.ec2_linux: instance.public_ip])
} 

output "windows_public_ips" {
  value = toset([for instance in aws_instance.ec2_windows: instance.public_ip])
} 

output "public_sg_ports" {
  description = "Public Security Groups Ports"
  value = toset([for sg in aws_security_group.public_sg.*.ingress: sg.*.from_port])
}

output "private_sg_ports" {
  description = "Private Security Groups Ports"
  value = toset([for sg in aws_security_group.private_sg.*.ingress: sg.*.from_port])
}