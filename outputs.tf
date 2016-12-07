output "private_subnet" {
  value = ["${aws_subnet.private.id}"]
}

output "public_subnet" {
  value = ["${aws_subnet.public.id}"]
}

output "vpc_id" {
  value = "${aws_vpc.basic.id}"
}

output "public_route_table_id" {
  value = ["${aws_route_table.public.id}"]
}

output "private_route_table_id" {
  value = ["${aws_route_table.private.id}"]
}

output "default_security_group_id" {
  value = "${aws_vpc.basic.default_security_group_id}"
}

output "developer_sg" {
  value = "${aws_security_group.developer.id}"
}
