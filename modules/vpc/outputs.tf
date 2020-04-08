output "vpc_id" {
  value = aws_vpc.main.id
}

output "vpc_cidr" {
  value = aws_vpc.main.cidr_block
}

output "public_subnets" {
  value = aws_subnet.public[*].id
}

output "private_subnets" {
  value = aws_subnet.private[*].id
}

output "private_route_tables" {
  value = aws_route_table.private[*].id
}

output "public_route_tables" {
  value = list(aws_route_table.public.id)
}

output "nat_eips" {
  value = aws_eip.nat[*].public_ip
}
