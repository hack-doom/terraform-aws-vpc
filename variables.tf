//         BIGINING
//   VPC VARIABLE DECLARATION
//
variable "vpc_cidr_block" {
  type        = string
  description = "Virtual Private Cloud(VPC) Classless Inter-Domain Routing(CIDR) Block"
  validation {
    condition = (
      try(tobool(try(cidrhost(var.vpc_cidr_block, 0), false)), true) &&
      try(tobool(try(cidrnetmask(var.vpc_cidr_block), false)), true)
    )
    error_message = "Invalid VPC CIDR Block !!"
  }
}

variable "instance_tenancy" {
  type        = string
  default     = "default"
  description = "VPC Instance Tenancy. It's value can be 'default' , 'dedicated' or 'host'"
  validation {
    condition     = contains(["default", "dedicated", "host"], var.instance_tenancy)
    error_message = "Only 'default' , 'dedicated' , 'host' are valid instance_tenancy !!"
  }
}

variable "enable_dns_support" {
  type        = bool
  default     = true
  description = "Enable DNS Support For VPC"
}

variable "enable_classiclink" {
  type        = bool
  default     = false
  description = "Enable Classiclink Support For VPC"
}

variable "enable_classiclink_dns_support" {
  type        = bool
  default     = false
  description = "Enable Classiclink DNS Support For VPC"
}

variable "assign_generated_ipv6_cidr_block" {
  type        = bool
  default     = false
  description = "Assigning IPv6 CIDR Block"
}

variable "vpc_tags" {
  type        = map(string)
  default     = null
  description = "VPC Tags"
  validation {
    condition     = var.vpc_tags == null ? true : !(contains([for tag_value in values(var.vpc_tags) : trimspace(tag_value)], ""))
    error_message = "VPC tag value that is empty string or only has whitespaces is not allowed !!"
  }
}

//         BIGINING
//   DHCP OPTIONS VARIABLE DECLARATION
//

variable "domain_name" {
  type        = string
  description = "Domain Name"
  validation {
    condition     = length(trimspace(var.domain_name)) != 0
    error_message = "If Domain Name is empty string or only has whitespaces is not allowed !!"
  }
}

variable "domain_name_servers" {
  type        = list(string)
  default     = ["AmazonProvidedDNS"]
  description = "Domain Name Servers  List"
  validation {
    condition = !(
      contains(tolist(
        toset([for server in var.domain_name_servers : (length(trimspace(server)) == 0) ? true : false])
        ), true
      )
    )
    error_message = "If A Domain Name Server Endpoint is empty string or only has whitespaces is not allowed !!"
  }
}

variable "ntp_servers" {
  type        = list(string)
  default     = null
  description = "NTP Servers  List"
  validation {
    condition = var.ntp_servers == null ? true : !(
      contains(tolist(
        toset([for server in var.ntp_servers : (length(trimspace(server)) == 0) ? true : false])
        ), true
      )
    )
    error_message = "If A NTP Server Endpoint is empty string or only has whitespaces is not allowed !!"
  }
}

variable "netbios_name_servers" {
  type        = list(string)
  default     = null
  description = "NetBIOS Name Servers List"
  validation {
    condition = var.netbios_name_servers == null ? true : !(
      contains(tolist(
        toset([for server in var.netbios_name_servers : (length(trimspace(server)) == 0) ? true : false])
        ), true
      )
    )
    error_message = "If A NetBIOS Name Server Endpoint is empty string or only has whitespaces is not allowed !!"
  }
}

variable "netbios_node_type" {
  type        = number
  default     = null
  description = "NetBIOS Node Type , Recommended 2"
  validation {
    condition     = var.netbios_node_type == null ? true : contains([1, 2, 4, 8], var.netbios_node_type)
    error_message = "NetBIOS Node Type can be only 1, 2, 4, or 8 !!"
  }
}

variable "dhcp_options_tags" {
  type        = map(string)
  default     = null
  description = "DHCP Options Tags"
  validation {
    condition     = var.dhcp_options_tags == null ? true : !(contains([for tag_value in values(var.dhcp_options_tags) : trimspace(tag_value)], ""))
    error_message = "DHCP Options tag value that is empty string or only has whitespaces is not allowed !!"
  }
}



variable "igw_tags" {
  type        = map(string)
  default     = null
  description = "Internet Gateway Tags"
  validation {
    condition     = var.igw_tags == null ? true : !(contains([for tag_value in values(var.igw_tags) : trimspace(tag_value)], ""))
    error_message = "IGW tag value that is empty string or only has whitespaces is not allowed !!"
  }
}

variable "rtb_cidr_block" {
  type        = string
  description = "Route Table CIDR Block"
  validation {
    condition = (
      try(tobool(try(cidrhost(var.rtb_cidr_block, 0), false)), true) &&
      try(tobool(try(cidrnetmask(var.rtb_cidr_block), false)), true)
    )
    error_message = "Invalid Route Table Internet Gateway CIDR Block !!"
  }
}

variable "public_rtb_tags" {
  type        = map(string)
  default     = null
  description = "Public Route Table Tags (Route Table which have rule for Internet Gateway)"
  validation {
    condition     = var.public_rtb_tags == null ? true : !(contains([for tag_value in values(var.public_rtb_tags) : trimspace(tag_value)], ""))
    error_message = "Public RTB tag value that is empty string or only has whitespaces is not allowed !!"
  }
}

variable "private_rtb_tags" {
  type        = map(string)
  default     = null
  description = "Private Route Table Tags (Route Table which doesn't have rule for Internet Gateway)"
  validation {
    condition     = var.private_rtb_tags == null ? true : !(contains([for tag_value in values(var.private_rtb_tags) : trimspace(tag_value)], ""))
    error_message = "Private RTB tag value that is empty string or only has whitespaces is not allowed !!"
  }
}
