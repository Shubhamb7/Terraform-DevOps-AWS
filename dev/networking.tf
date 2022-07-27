resource "aws_vpc" "vpc" {
  cidr_block       = var.vpc_cidr_block
  instance_tenancy = "default"
  enable_dns_hostnames = true
  enable_dns_support = true

  tags = {
    Name = "${var.env}-vpc"
  }
}

resource "aws_subnet" "public_subnet" {
  count = length(var.subnet_availability_zones)
  vpc_id     = aws_vpc.vpc.id
  cidr_block = element(var.public_subnet_cidr,count.index)
  availability_zone = element(var.subnet_availability_zones,count.index)
  map_public_ip_on_launch = true

  tags = {
    Name = "${var.env}-public-subnet"
  }
}

resource "aws_subnet" "private_subnet" {
  count = length(var.subnet_availability_zones)
  vpc_id     = aws_vpc.vpc.id
  cidr_block = element(var.private_subnet_cidr,count.index)
  availability_zone = element(var.subnet_availability_zones,count.index)
  map_public_ip_on_launch = false

  tags = {
    Name = "${var.env}-private-subnet"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "${var.env}-IGW"
  }
}

resource "aws_eip" "ngw_eip" {
  vpc = true
}

resource "aws_nat_gateway" "ngw" {
  subnet_id = aws_subnet.public_subnet[0].id
  allocation_id = aws_eip.ngw_eip.id

  tags = {
    Name = "${var.env}-NGW"
  }
}

resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "${var.env}-public-rt"
  }
}

resource "aws_route_table" "private_rt" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id =  aws_nat_gateway.ngw.id
  }

  tags = {
    Name = "${var.env}-private-rt"
  }
}

resource "aws_route_table_association" "public_rt_association1" {
  subnet_id      = aws_subnet.public_subnet[0].id
  route_table_id = aws_route_table.public_rt.id
}
resource "aws_route_table_association" "public_rt_association2" {
  subnet_id      = aws_subnet.public_subnet[1].id
  route_table_id = aws_route_table.public_rt.id
}

resource "aws_route_table_association" "private_rt_association1" {
  subnet_id      = aws_subnet.private_subnet[0].id
  route_table_id = aws_route_table.private_rt.id
}

resource "aws_route_table_association" "private_rt_association2" {
  subnet_id      = aws_subnet.private_subnet[1].id
  route_table_id = aws_route_table.private_rt.id
}