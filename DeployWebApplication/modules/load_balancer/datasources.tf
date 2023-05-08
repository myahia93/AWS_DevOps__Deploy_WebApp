data "aws_vpc" "vpc" {
  filter {
    name   = "tag:Name"
    values = ["VPC-${var.__webapp_name}"]
  }
}

data "aws_subnet" "snet-public" {
  count = length(var.__az)
  filter {
    name   = "tag:Name"
    values = ["Public-Subnet-${var.__az[count.index]}"]
  }
}
