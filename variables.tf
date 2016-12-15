variable "name" {}

variable "vpc_iprange_prefix" {}

variable "developer_ips" {
  default = []
}

variable "ingress_port" {
  default = []
}

variable "enable_dns_hostnames" {
  default = true
}

variable "enable_dns_support" {
  default = true
}

variable "az" {}
