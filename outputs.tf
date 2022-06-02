output "linux_public_ips" {
  value = toset([for instance in aws_instance.ec2_linux: instance.public_ip])
} 

output "windows_public_ips" {
  value = toset([for instance in aws_instance.ec2_windows: instance.public_ip])
} 
