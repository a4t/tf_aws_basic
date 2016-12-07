provider "aws" {
  region = "ap-northeast-1"
}

module "sample" {
  source             = "/tf_aws_basic"
  name               = "tf_aws_basic_sample"
  vpc_iprange_prefix = "192.168.1"
  az                 = "ap-northeast-1a"

  developer_ips = "${var.developer_ips}"
}
