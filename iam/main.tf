terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }

  required_version = ">= 1.2.0"
}

provider "aws" {
  region  = "us-east-1"
  
}


provider "aws" {
  region = "us-east-1"  # Set your desired AWS region
}

resource "aws_iam_user" "lucy" {
  name = "lucy"
}

resource "aws_iam_user_policy_attachment" "lucy_admin" {
  user       = aws_iam_user.lucy.name
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}

resource "aws_iam_access_key" "lucy_access_key" {
  user = aws_iam_user.lucy.name
}

output "access_key_id" {
  value = aws_iam_access_key.lucy_access_key.id
}

output "secret_access_key" {
  value = aws_iam_access_key.lucy_access_key.secret
}
