resource "aws_security_group" "ec2" {
  name        = "ec2"
  description = "ec2 security group"

  tags = {
    Name = "ec2"
  }
}

resource "aws_vpc_security_group_ingress_rule" "sshfrommyIP" {
  security_group_id = aws_security_group.ec2.id
  cidr_ipv4         = "27.4.103.246/32"
  from_port         = 22
  ip_protocol       = "tcp"
  to_port           = 22
}

resource "aws_vpc_security_group_ingress_rule" "allowhttp" {
  security_group_id = aws_security_group.ec2.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 80
  ip_protocol       = "tcp"
  to_port           = 80
}


resource "aws_vpc_security_group_egress_rule" "allowalloutbound_ipv4" {
  security_group_id = aws_security_group.ec2.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}

resource "aws_vpc_security_group_egress_rule" "allowalloutbound_ipv6" {
  security_group_id = aws_security_group.ec2.id
  cidr_ipv6         = "::/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}

resource "aws_vpc_security_group_ingress_rule" "allow_app1_port" {
  security_group_id = aws_security_group.ec2.id
  cidr_ipv4         = "0.0.0.0/0"  # Allow from anywhere (change to restrict access)
  from_port         = 8081
  ip_protocol       = "tcp"
  to_port           = 8081
}

resource "aws_vpc_security_group_ingress_rule" "allow_app2_port" {
  security_group_id = aws_security_group.ec2.id
  cidr_ipv4         = "0.0.0.0/0"  # Allow from anywhere (change to restrict access)
  from_port         = 8082
  ip_protocol       = "tcp"
  to_port           = 8082
}