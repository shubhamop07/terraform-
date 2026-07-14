resource "aws_vpc" "main" {
  cidr_block = var.vpc_config.cidr_block

  tags = {
    Name = var.vpc_config.name
  }
}

resource "aws_subnet" "main" {
  for_each = var.subnet_config

  vpc_id                  = aws_vpc.main.id
  cidr_block              = each.value.cidr_block
  availability_zone       = each.value.az
  map_public_ip_on_launch = each.value.public

  tags = {
    Name = each.key
  }
}

locals {
  public_subnets = {
    for key, value in var.subnet_config :
    key => value
    if value.public
  }
}

resource "aws_internet_gateway" "main" {
  count = length(local.public_subnets) > 0 ? 1 : 0

  vpc_id = aws_vpc.main.id

  tags = {
    Name = "${var.vpc_config.name}-igw"
  }
}

resource "aws_route_table" "main" {
  count = length(local.public_subnets) > 0 ? 1 : 0

  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main[0].id
  }

  tags = {
    Name = "${var.vpc_config.name}-public-rt"
  }
}

resource "aws_route_table_association" "main" {
  for_each = local.public_subnets

  subnet_id      = aws_subnet.main[each.key].id
  route_table_id = aws_route_table.main[0].id
}