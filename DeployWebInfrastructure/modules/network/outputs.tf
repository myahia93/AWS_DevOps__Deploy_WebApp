output "vpc_id" {
  description = "The vpc id"
  value       = aws_vpc.vpc.id
}

output "vpc_default_rt" {
  description = "The vpc id"
  value       = aws_vpc.vpc.default_route_table_id
}

output "public_subnets" {
  description = "The ids of public subnets"
  value       = aws_subnet.snet-public.*.id
}

output "private_subnets" {
  description = "The ids of subnets created inside the newl vNet"
  value       = aws_subnet.snet-private.*.id
}

output "igw_id" {
  description = "The internet gateway id"
  value       = aws_internet_gateway.igw.id
}
