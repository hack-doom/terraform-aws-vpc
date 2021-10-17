# AWS VPC Terraform module

Terraform module which creates VPC, DHCP Options & its association, Internet Gateway, Route Tables( Two , first has rule for Internet GateWay . It can be used in public subnet And other route table doesn't have rule for internet. It can be used for private) resources on AWS.

## Usage

```hcl
module "vpc" {
  source = "hack-doom/vpc/aws"
  version = "0.0.1"
  vpc_cidr_block = "192.168.0.0/16"
  domain_name    = "hack.doom"
  rtb_cidr_block = "0.0.0.0/0"
}
```