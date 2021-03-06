resource "aws_vpc" "basic" {
  cidr_block           = "${var.vpc_iprange_prefix}.0/24"
  enable_dns_hostnames = "${var.enable_dns_hostnames}"
  enable_dns_support   = "${var.enable_dns_support}"

  tags {
    Name = "${var.name}"
    Role = "vpc"
  }
}

resource "aws_internet_gateway" "basic" {
  vpc_id = "${aws_vpc.basic.id}"

  tags {
    Name = "${var.name}"
    Role = "igw"
  }
}

resource "aws_route_table" "public" {
  vpc_id = "${aws_vpc.basic.id}"

  tags {
    Name = "${var.name}-public"
    Role = "public"
  }
}

resource "aws_route_table" "private" {
  vpc_id = "${aws_vpc.basic.id}"

  tags {
    Name = "${var.name}-private"
    Role = "private"
  }
}

resource "aws_route" "public_internet_gateway" {
  route_table_id         = "${aws_route_table.public.id}"
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = "${aws_internet_gateway.basic.id}"
}

resource "aws_subnet" "public" {
  vpc_id                  = "${aws_vpc.basic.id}"
  cidr_block              = "${var.vpc_iprange_prefix}.0/28"
  availability_zone       = "${var.az}"
  map_public_ip_on_launch = true

  tags {
    Name = "${var.name}-public"
  }
}

resource "aws_subnet" "private" {
  vpc_id            = "${aws_vpc.basic.id}"
  cidr_block        = "${var.vpc_iprange_prefix}.16/28"
  availability_zone = "${var.az}"

  tags {
    Name = "${var.name}-private"
  }
}

resource "aws_route_table_association" "public" {
  subnet_id      = "${aws_subnet.public.id}"
  route_table_id = "${aws_route_table.public.id}"
}

resource "aws_route_table_association" "private" {
  subnet_id      = "${aws_subnet.private.id}"
  route_table_id = "${aws_route_table.private.id}"
}

resource "aws_security_group" "developer" {
  name   = "${var.name}-developer"
  vpc_id = "${aws_vpc.basic.id}"

  tags {
    Name = "${var.name}-developer"
  }
}

resource "aws_security_group_rule" "egress" {
  type        = "egress"
  from_port   = 0
  to_port     = 0
  protocol    = "-1"
  cidr_blocks = ["0.0.0.0/0"]

  security_group_id = "${aws_security_group.developer.id}"
}

resource "aws_security_group_rule" "ingress_ports" {
  count       = "${length(var.ingress_port)}"
  type        = "ingress"
  from_port   = "${element(var.ingress_port, count.index)}"
  to_port     = "${element(var.ingress_port, count.index)}"
  protocol    = "tcp"
  cidr_blocks = "${var.developer_ips}"

  security_group_id = "${aws_security_group.developer.id}"
}

