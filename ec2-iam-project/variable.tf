variable "region" {
  type = string
  description = "This is to mention the region"
}

variable "iam-user" {
  type = list(string)
  description = "This is to indicate the IAM user names"
}
variable "iam-user-permissions_boundary" {
  type = string
  description = "This is to attach the permission boundary to IAM users"
}

variable "IAM-group" {
  type = string
  description = "This is to indicate the IAM-group"
}

variable "iam-group-policy" {
  type = list(string)
  description = "This is to attach the policy to iam group"
}

variable "prod-sg-name" {
  type = string
  description = "This is to mention the SG group name"
}

variable "prod-sg-http" {
  type = map(string)
  description = "This is to mention tne prod-sg-http ingress ports"
}

variable "prod-sg-ssh-cidr" {
    type = string
    description = "This is to mention tne prod-sg-ssh cidr"
}

variable "prod-sg-ssh" {
    type = map(string)
    description = "This is to mention tne prod-sg-ssh ingress ports"
}

variable "prod-sg-Egress-cidr" {
  type = string
  description = "This is to indicate the prod-sg-Egress cidr"
}

variable "prod-web-servers-ami" {
  type = string
  description = "This is to indicate the ami for prod-web servers"
}

variable "prod-web-servers-instance_type" {
  type = string
  description = "This is to indicate the instance type for prod-web servers"
}

variable "useradd-script" {
  type = string
  description = "This is to mention the user add script while building the ec2"
}
variable "prod-web-servers-tags" {
  type = list(string)
  description = "This is to indicate the tags "
}

