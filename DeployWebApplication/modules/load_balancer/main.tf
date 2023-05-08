# Security Group
resource "aws_security_group" "sg-elb" {
  name        = "SG-ELB"
  description = "Allow HTTP inbound traffic"
  vpc_id      = data.aws_vpc.vpc.id

  ingress {
    description = "HTTP from internet"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "SG-ELB"
  }
}

# Elastic Load Balancer
resource "aws_elb" "elb" {
  name                      = "elb-${var.__webapp_name}"
  subnets                   = data.aws_subnet.snet-public.*.id
  security_groups           = [aws_security_group.sg-elb.id]
  cross_zone_load_balancing = true

  listener {
    instance_port     = 8080
    instance_protocol = "HTTP"
    lb_port           = 80
    lb_protocol       = "HTTP"
  }

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    target              = "HTTP:8080/"
    interval            = 30
  }
}
