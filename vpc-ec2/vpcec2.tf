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


# Create a VPc
resource "aws_vpc" "dev" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "dev-vpc"
  }

}

# Create a AWS internet Gateway
resource "aws_internet_gateway" "dev_gateway" {
    vpc_id = aws_vpc.dev.id

    tags = {
      Name = "Dev Gateway"
    }
  
}

# Creating a subnet

resource "aws_subnet" "dev_public" {
  vpc_id            = aws_vpc.dev.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "us-east-1a"

  map_public_ip_on_launch = true

  tags = {
    Name = "public-subnet"
  }
}

# Create Route Table and Add Public Route
resource "aws_route_table" "public-route-table" {
  vpc_id = aws_vpc.dev.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.dev_gateway.id
  }

}



resource "aws_route_table_association" "dev_public_to_out" {
subnet_id           = aws_subnet.dev_public.id
route_table_id      = aws_route_table.public-route-table.id
}


# security group 
resource "aws_security_group" "dev" {
  
  vpc_id      = aws_vpc.dev.id

  ingress {

    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = [aws_vpc.dev.cidr_block]
    
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "allow_all"
  }
}

resource "aws_instance" "dev_server" {
  ami           = "ami-0230bd60aa48260c6"
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.dev_public.id
  security_groups = [aws_security_group.dev.id]
  associate_public_ip_address = true

  tags = {
    Name = "dev"
  }

}
