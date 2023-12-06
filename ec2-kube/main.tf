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

resource "aws_instance" "ec2_instance" {
  count = length(var.instance_names)

  ami           = var.ami_name
  instance_type = "t2.micro"  # replace with your desired instance type
  key_name = "madhuansible"

  tags = {
    Name = var.instance_names[count.index]
  }
}

