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
}


resource "aws_subnet" "private_subnet" {
  count = length(var.Private_subnet_cidr)  
  vpc_id = aws_vpc.vpc.id
  cidr_block = element(var.Private_subnet_cidr, count.index)
}