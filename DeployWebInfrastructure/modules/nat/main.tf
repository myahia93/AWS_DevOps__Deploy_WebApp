# NAT Security Group
resource "aws_security_group" "sg-nat" {
  name        = "SG-NAT"
  description = "Allow SSH inbound traffic"
  vpc_id      = var.__vpc_id

  ingress {
    description = "SSH from my IP"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = var.__my_ip
  }

  tags = {
    Name = "SG-NAT"
  }
}

# NAT Instance
resource "aws_instance" "nat" {
  ami                         = var.__nat_ami
  instance_type               = "t2.micro"
  subnet_id                   = var.__subnet_id
  associate_public_ip_address = true
  vpc_security_group_ids      = [aws_security_group.sg-nat.id]
  key_name                    = "vockey"

  user_data = <<EOF
#!/bin/bash
sysctl -w net.ipv4.ip_forward=1
/sbin/iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE
  EOF

  tags = {
    Name = "NAT"
  }
}
