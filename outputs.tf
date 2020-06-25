output "instance_ip_pub_addr" {
  value       = aws_instance.ubuntu.public_ip
  description = "The public IP address of the Ubuntu_ec2 instance."
}

output "instance_ip_priv_addr" {
  value       = aws_instance.ubuntu.private_ip
  description = "The private IP address of the Ubuntu_ec2 instance."
}

output "instance_host_id" {
  value       = aws_instance.ubuntu.host_id
  description = "The host_id of the Ubuntu_ec2 instance."
}

output "instance_id" {
  value       = aws_instance.ubuntu.id
  description = "The id of the Ubuntu_ec2 instance."
}

output "aws_VPC" {
  value       = aws_vpc.main_vpc.id
  description = "The id of the VPC."
}

output "aws_subnet_pub_1" {
  value       = aws_subnet.pub_1.id
  description = "The id of the PUB_1 subnet."
}

output "aws_subnet_pub_2" {
  value       = aws_subnet.pub_2.id
  description = "The id of the PUB_2 subnet."
}

output "aws_subnet_pub_3" {
  value       = aws_subnet.pub_3.id
  description = "The id of the PUB_3 subnet."
}

output "aws_subnet_priv_1" {
  value       = aws_subnet.priv_1.id
  description = "The id of the priv_1 subnet."
}

output "aws_subnet_priv_2" {
  value       = aws_subnet.priv_2.id
  description = "The id of the priv_2 subnet."
}

output "aws_subnet_priv_3" {
  value       = aws_subnet.priv_3.id
  description = "The id of the priv_3 subnet."
}

output "aws_ig" {
  value       = aws_internet_gateway.main_igw.id
}

output "aws_pub_rt" {
  value       = aws_route_table.pub_rt.id
}

output "aws_priv_1_rt" {
  value       = aws_route_table.priv_1_rt.id
}

output "aws_priv_2_rt" {
  value       = aws_route_table.priv_2_rt.id
}

output "aws_priv_3_rt" {
  value       = aws_route_table.priv_3_rt.id
}

output "aws_rt_association_a" {
  value       = aws_route_table_association.a.id
}

output "aws_rt_association_b" {
  value       = aws_route_table_association.b.id
}

output "aws_rt_association_c" {
  value       = aws_route_table_association.c.id
}
