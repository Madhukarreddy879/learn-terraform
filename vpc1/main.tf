terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  
}

provider "aws" {
  region  = "us-east-1"
  
}



resource "aws_vpc" "vpc" {
    cidr_block = "10.0.0.0/16"
    

    tags = {
      Name = "Project Vpc"
    }
  
}

resource "aws_subnet" "public_subnet" {
  count = length(var.Public_subnet_cidr)  
  vpc_id = aws_vpc.vpc.id
  cidr_block = element(var.Public_subnet_cidr, count.index)
  availability_zone = element(var.azs, count.index)
  

  tags = {
    Name = "Public Subnet ${count.index + 1}"
  }
}


resource "aws_subnet" "private_subnet" {
  count = length(var.Private_subnet_cidr)  
  vpc_id = aws_vpc.vpc.id
  cidr_block = element(var.Private_subnet_cidr, count.index)
  availability_zone = element(var.azs, count.index)

  tags = {
    Name = "Privata Subnet ${count.index + 1}"
  }
}


resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "Project VPC  IG"
  }
}


