provider "aws" {
  region = "ap-south-1"  # Replace with your desired AWS region
}

# Create an IAM User
resource "aws_iam_user" "example_user" {
  name = "Pradeep"  # Replace with your desired user name
  path = "/"
}
