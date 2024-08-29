provider "aws" {
  region = var.region
}

resource "aws_iam_user" "Iam-user" {
    name = "${var.iam-user[count.index]}"
    count = length(var.iam-user)
    permissions_boundary = var.iam-user-permissions_boundary
}

resource "aws_iam_group" "IAM-group" {
  name = var.IAM-group
}

resource "aws_iam_user_group_membership" "group-mem" {
  user = aws_iam_user.Iam-user[count.index].name
  count = length(var.iam-user)
  groups = [ aws_iam_group.IAM-group.name ]
  
}

resource "aws_iam_group_policy_attachment" "IAM-group-policy" {
  group = aws_iam_group.IAM-group.name
  count = length(var.iam-group-policy)
  policy_arn = var.iam-group-policy[count.index]
}

resource "aws_eip" "EIP" {
  domain = "vpc"
}

resource "aws_security_group" "prod-sg" {
  name = var.prod-sg-name
}

resource "aws_vpc_security_group_ingress_rule" "prod-sg-http" {
  security_group_id = aws_security_group.prod-sg.id
  cidr_ipv4 = "${aws_eip.EIP.public_ip}/32"
  ip_protocol = "tcp"
  from_port = var.prod-sg-http["from_port"]
  to_port = var.prod-sg-http["to_port"]
}

resource "aws_vpc_security_group_ingress_rule" "prod-sg-ssh" {
  security_group_id = aws_security_group.prod-sg.id
  cidr_ipv4 = "${var.prod-sg-ssh-cidr}"
  ip_protocol = "tcp"
  from_port = var.prod-sg-ssh["from_port"]
  to_port = var.prod-sg-ssh["to_port"]
}

resource "aws_vpc_security_group_egress_rule" "prod-sg-Egress" {
  security_group_id = aws_security_group.prod-sg.id
  cidr_ipv4 = var.prod-sg-Egress-cidr
  ip_protocol = "-1"
}

resource "aws_instance" "prod-web-servers" {
  ami = var.prod-web-servers-ami
  instance_type = var.prod-web-servers-instance_type
  count = length(var.prod-web-servers-tags)
  security_groups = count.index ==2 ? [aws_security_group.prod-sg.name] : []
  user_data = file(var.useradd-script)
  tags = {
    Name = "${var.prod-web-servers-tags[count.index]}"
  }
}

resource "aws_eip_association" "EIP-ec2" {
  instance_id = aws_instance.prod-web-servers[0].id
  allocation_id = aws_eip.EIP.allocation_id
}

output "EIP" {
  value = aws_eip.EIP.public_ip
}

output "ec2-id" {
  value = aws_instance.prod-web-servers[*].id
}

output "ec2-public-IP" {
  value = aws_instance.prod-web-servers[*].public_ip
  
}



