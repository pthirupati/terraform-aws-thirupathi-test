terraform {
  required_providers {
    aws = {
        source = "hashicorp/aws"
        version = "~> 5.0"
    }
  }
}


provider "aws" {
  region = "ap-south-1"
}


resource "aws_iam_user" "Prod" {
    name = "prod-user"
    permissions_boundary = "arn:aws:iam::aws:policy/IAMReadOnlyAccess"
}

resource "aws_iam_group" "prod-group" {
  name = "prod-gorup"
}

resource "aws_iam_user_group_membership" "prod-group-mem" {
  user = aws_iam_user.Prod.name
  groups = [aws_iam_group.prod-group.name]
}

resource "aws_iam_group_policy_attachment" "prod-group-policy" {
  group = aws_iam_group.prod-group.name
  policy_arn = "arn:aws:iam::aws:policy/IAMFullAccess"
}

resource "aws_eip" "EIP" {
  domain = "vpc"
}

resource "aws_security_group" "prod-sg" {
  name = "prod-sg"
}

resource "aws_vpc_security_group_ingress_rule" "HTTPS" {
  security_group_id = aws_security_group.prod-sg.id
  ip_protocol = "tcp"
  cidr_ipv4 = "0.0.0.0/0"
  from_port = 443
  to_port = 443
}


resource "aws_vpc_security_group_ingress_rule" "HTTP" {
  security_group_id = aws_security_group.prod-sg.id
  ip_protocol = "tcp"
  cidr_ipv4 = "0.0.0.0/0"
  from_port = 80
  to_port = 80
}

resource "aws_vpc_security_group_ingress_rule" "SSH" {
    security_group_id = aws_security_group.prod-sg.id
    ip_protocol = "tcp"
    cidr_ipv4 = "${aws_eip.EIP.public_ip}/32"
    from_port = 22
    to_port = 22
}


resource "aws_vpc_security_group_egress_rule" "All-traffic-egress" {
    security_group_id = aws_security_group.prod-sg.id
    cidr_ipv4 = "0.0.0.0/0"
    ip_protocol = "-1"
}


resource "aws_instance" "Prod-instance" {
  ami = "ami-0ec0e125bb6c6e8ec"
  instance_type = "t2.micro"
  tags = {
    Name = "Webserver-1"
  }
  security_groups = [ aws_security_group.prod-sg.id ]
}

resource "aws_eip_association" "Prod-instance-EIP" {
  instance_id = aws_instance.Prod-instance.id
  allocation_id = aws_eip.EIP.allocation_id
}

output "IAM" {
  value = aws_iam_user.Prod.id
}

output "EIP" {
  value = aws_eip.EIP.public_ip
}

output "Ec2" {
  value = aws_instance.Prod-instance
}




