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

# Create VPC

resource "aws_vpc" "vpc" {
cidr_block = "10.0.0.0/16"
instance_tenancy        = "default"
enable_dns_hostnames    = true
tags      = {
Name    = "Test_VPC"
}
}


# Create Internet Gateway and Attach it to VPC
# terraform aws create internet gateway
resource "aws_internet_gateway" "internet-gateway" {
vpc_id    = aws_vpc.vpc.id
tags = {
Name    = "internet_gateway"
}
}


resource "aws_subnet" "public-subnet-1" {
vpc_id                  = aws_vpc.vpc.id
cidr_block              = "10.0.0.0/24"
map_public_ip_on_launch = true
tags      = {
Name    = "public-subnet-1"
}
}


resource "aws_route_table" "public-route-table" {
vpc_id       = aws_vpc.vpc.id
route {
cidr_block = "0.0.0.0/0"
gateway_id = aws_internet_gateway.internet-gateway.id
}
tags       = {
Name     = "Public Route Table"
}
}

resource "aws_route_table_association" "public-subnet-1-route-table-association" {
subnet_id           = aws_subnet.public-subnet-1.id
route_table_id      = aws_route_table.public-route-table.id
}

resource "aws_security_group" "name" {
    
  
}
