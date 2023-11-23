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

resource "aws_route_table" "second_rt" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id

    }

    tags =  {
       Name = "2nd route table"

    }
  }

resource "aws_route_table_association" "public_subnet_asso" {
 count = var(var.Public_subnet_cidr)
 subnet_id      = element(aws_subnet.public_subnet[*].id, count.index)
 route_table_id = aws_route_table.second_rt.id
}

