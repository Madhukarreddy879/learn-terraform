provider "aws" {
  region = var.aws_region
}

resource "aws_instance" "ec2_instance" {
  count = length(var.instance_names)

  ami           = var.ami_name
  instance_type = "t2.micro"  # replace with your desired instance type

  tags = {
    Name = var.instance_names[count.index]
  }
}

