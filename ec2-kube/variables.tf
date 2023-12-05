

variable "ami_name" {
  description = "AMI name"
  default     = "ami-830c94e3"
}

variable "instance_names" {
  description = "List of instance names"
  type        = list(string)
  default     = ["master", "node1", "node2"]
}
