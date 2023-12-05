variable "aws_region" {
  description = "AWS region"
  default     = "us-east-1"
}

variable "ami_name" {
  description = "AMI name"
  default     = "ami-0230bd60aa48260c6"
}

variable "instance_names" {
  description = "List of instance names"
  type        = list(string)
  default     = ["master", "node1", "node2"]
}
