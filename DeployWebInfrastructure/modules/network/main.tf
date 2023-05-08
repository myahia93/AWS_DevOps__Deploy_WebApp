# VPC
resource "aws_vpc" "vpc" {
  cidr_block       = var.__vpc_cidr
  instance_tenancy = "default"

  tags = {
    Name = "VPC-${var.__webapp_name}"
  }
}

# Subnets

# Public
resource "aws_subnet" "snet-public" {
  count                   = length(var.__snet_public_cidr)
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.__snet_public_cidr[count.index]
  availability_zone       = "${var.__region}${var.__az[count.index]}"
  map_public_ip_on_launch = true

  tags = {
    Name = "Public-Subnet-${var.__az[count.index]}"
  }
}
#Private
resource "aws_subnet" "snet-private" {
  count                   = length(var.__snet_private_cidr)
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.__snet_private_cidr[count.index]
  availability_zone       = "${var.__region}${var.__az[count.index]}"
  map_public_ip_on_launch = false

  tags = {
    Name = "Private-Subnet-${var.__az[count.index]}"
  }
}

# Internet Gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "IGW-${var.__webapp_name}"
  }
}
