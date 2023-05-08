# Route table

#Main RT
resource "aws_default_route_table" "rt-main" {
  default_route_table_id = var.__vpc_default_rt

  tags = {
    Name = "Main-RouteTable-${var.__webapp_name}"
  }
}
resource "aws_route" "route-main-to-internet" {
  route_table_id         = aws_default_route_table.rt-main.id
  destination_cidr_block = "0.0.0.0/0"
  network_interface_id   = var.__nat_eni_id
}

#Public RT
resource "aws_route_table" "rt-public" {
  vpc_id = var.__vpc_id

  tags = {
    Name = "Public-RouteTable-${var.__webapp_name}"
  }
}
resource "aws_route" "route-public-to-internet" {
  route_table_id         = aws_route_table.rt-public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = var.__igw_id
}
resource "aws_route_table_association" "rt-public-subnet" {
  count          = length(var.__snet_public_ids)
  route_table_id = aws_route_table.rt-public.id
  subnet_id      = var.__snet_public_ids[count.index]
}
