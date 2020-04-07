resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = var.name
  }
}

resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = var.name
  }
}

resource "aws_eip" "nat" {
  count = var.nat_per_az ? var.number_of_azs : 1
  vpc   = true
}

resource "aws_nat_gateway" "main" {
  count         = var.nat_per_az ? var.number_of_azs : 1
  allocation_id = aws_eip.nat[count.index].id
  subnet_id     = aws_subnet.public[count.index].id

  tags = {
    Name = var.name
  }
}
