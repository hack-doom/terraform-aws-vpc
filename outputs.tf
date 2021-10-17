output "vpc" {
  value       = aws_vpc.vpc
  description = "AWS VPC Information"
}

output "dhcp_options" {
  value       = aws_vpc_dhcp_options.dhcp_options
  description = "AWS VPC DHCP Options Information"
}

output "igw" {
  value       = aws_internet_gateway.igw
  description = "AWS VPC Internet Gateway Information"
}

output "public_route_table" {
  value       = aws_route_table.public_route_table
  description = "Public Route Table Information"
}

output "private_route_table" {
  value       = aws_route_table.private_route_table
  description = "Private Route Table Information"
}
