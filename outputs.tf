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
