resource "aws_vpc" "vpc" {
  cidr_block                       = var.vpc_cidr_block
  instance_tenancy                 = var.instance_tenancy
  enable_classiclink               = var.enable_classiclink
  enable_classiclink_dns_support   = var.enable_classiclink_dns_support
  enable_dns_support               = var.enable_dns_support
  enable_dns_hostnames             = var.enable_dns_support
  assign_generated_ipv6_cidr_block = var.assign_generated_ipv6_cidr_block
  tags                             = var.vpc_tags
}

resource "aws_vpc_dhcp_options" "dhcp_options" {
  domain_name          = var.domain_name
  domain_name_servers  = var.domain_name_servers
  ntp_servers          = var.ntp_servers
  netbios_name_servers = var.netbios_name_servers
  netbios_node_type    = var.netbios_node_type
  tags                 = var.dhcp_options_tags
  depends_on = [
    aws_vpc.vpc
  ]
}

resource "aws_vpc_dhcp_options_association" "dhcp_options_association" {
  vpc_id          = aws_vpc.vpc.id
  dhcp_options_id = aws_vpc_dhcp_options.dhcp_options.id
  depends_on = [
    aws_vpc_dhcp_options.dhcp_options
  ]
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id
  tags   = var.igw_tags
  depends_on = [
    aws_vpc.vpc
  ]
}

resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.vpc.id
  tags   = var.public_rtb_tags
}

resource "aws_route" "public_route" {
  route_table_id         = aws_route_table.public_route_table.id
  destination_cidr_block = var.rtb_cidr_block
  gateway_id             = aws_internet_gateway.igw.id
  depends_on = [
    aws_internet_gateway.igw,
    aws_route_table.public_route_table
  ]
}

resource "aws_route_table" "private_route_table" {
  vpc_id = aws_vpc.vpc.id
  tags   = var.private_rtb_tags
  depends_on = [
    aws_vpc.vpc
  ]
}
