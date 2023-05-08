data "aws_ami" "webapp" {
  filter {
    name   = "tag:Name"
    values = ["${var.__webapp_name}"]
  }
  most_recent = true
}

data "aws_vpc" "vpc" {
  filter {
    name   = "tag:Name"
    values = ["VPC-${var.__webapp_name}"]
  }
}

data "aws_subnet" "snet-private" {
  count = length(var.__az)
  filter {
    name   = "tag:Name"
    values = ["Private-Subnet-${var.__az[count.index]}"]
  }
}
