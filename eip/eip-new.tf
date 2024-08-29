provider "aws" {
  region = "ap-south-1"  # Change to your preferred region
}

# Resource to create an Elastic IP
resource "aws_eip" "my_eip" {
  vpc = true  # Set to true if you want the EIP to be in a VPC
}

# Output the Elastic IP address
output "eip_address" {
  value = aws_eip.my_eip.public_ip
  description = "The public IP address of the created Elastic IP"
}
