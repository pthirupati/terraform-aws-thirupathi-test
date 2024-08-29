region = "ap-south-1"
iam-user = ["thirupathi", "Guna","krishna","Hari","Midhun"]
iam-user-permissions_boundary = "arn:aws:iam::aws:policy/IAMReadOnlyAccess"
IAM-group = "Comcast"
iam-group-policy = ["arn:aws:iam::aws:policy/IAMFullAccess"]
prod-sg-name = " prod-sg"
prod-sg-http = {"from_port"=8080, "to_port"=8080}
prod-sg-ssh-cidr = "0.0.0.0/0"
prod-sg-ssh = {"from_port"=22, "to_port"=22}
prod-sg-Egress-cidr = "0.0.0.0/0"
prod-web-servers-ami = "ami-0ec0e125bb6c6e8ec"
prod-web-servers-instance_type = "t2.micro"
useradd-script = "useradd.sh"
prod-web-servers-tags = ["Web-server", "App-Server"]
