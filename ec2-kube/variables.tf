

variable "ami_name" {
  description = "AMI name"
  default     = "ami-0230bd60aa48260c6"
}

variable "instance_names" {
  description = "List of instance names"
  type        = list(string)
  default     = ["web", "apache", ]
}
