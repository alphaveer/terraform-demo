resource "aws_route_table" "private" {
  count  = var.number_of_azs
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "${var.name} private"
  }
}

resource "aws_route" "private" {
  count                    = var.number_of_azs
  route_table_id           = aws_route_table.private[count.index].id
  destination_cidr_block   = "0.0.0.0/0"
  nat_gateway_id           = element(aws_nat_gateway.main[*].id, count.index)
}

resource "aws_subnet" "private" {
  count             = var.number_of_azs
  vpc_id            = aws_vpc.main.id
  cidr_block        = cidrsubnet(var.vpc_cidr, var.subnet_offset, count.index + var.number_of_azs)
  availability_zone = element(local.availability_zone, count.index)
  tags = {
    Name = "${var.name} private ${count.index + 1}"
  }
}

resource "aws_route_table_association" "private" {
  count          = length(aws_subnet.private[*].id)
  subnet_id      = aws_subnet.private[count.index].id
  route_table_id = aws_route_table.private[count.index].id
}
