output "vpc_id" {
  value = aws_vpc.tocoder_vpc.id
  description = "vpc resource id"
}

output "public_subnet_id" {
  value = aws_subnet.tocoder_public_subnet[*].id 
  description = "public subnet id"
}

output "private_subnet_id" {
  value = aws_subnet.tocoder_private_subnet[*].id 
  description = "private subnet id"
}

output "security_group_id" {
  value = aws_security_group.tocoder_https.id 
  description = "security group id"
}

