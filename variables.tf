variable "name" {}

variable "vpc_iprange_prefix" {}

variable "developer_ips" {
  default = []
}

variable "enable_dns_hostnames" {
  default = false
}

variable "enable_dns_support" {
  default = false
}

variable "enable_nat_gateway" {
  default = false
}

variable "az" {}
