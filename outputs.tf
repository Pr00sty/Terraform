output "instance_ip_pub_addr" {
  value       = aws_instance.Ubuntu.public_ip
  description = "The public IP address of the Ubuntu_ec2 instance."
}

output "instance_ip_priv_addr" {
  value       = aws_instance.Ubuntu.private_ip
  description = "The private IP address of the Ubuntu_ec2 instance."
}

output "instance_host_id" {
  value       = aws_instance.Ubuntu.host_id
  description = "The host_id of the Ubuntu_ec2 instance."
}

output "instance_id" {
  value       = aws_instance.Ubuntu.id
  description = "The id of the Ubuntu_ec2 instance."
}

output "aws_VPC" {
  value       = aws_vpc.Paw_main_vpc.id
  description = "The id of the VPC."
}

output "aws_subnet_pub_1" {
  value       = aws_subnet.PUB_1.id
  description = "The id of the PUB_1 subnet."
}

output "aws_subnet_pub_2" {
  value       = aws_subnet.PUB_2.id
  description = "The id of the PUB_2 subnet."
}

output "aws_subnet_pub_3" {
  value       = aws_subnet.PUB_3.id
  description = "The id of the PUB_3 subnet."
}
