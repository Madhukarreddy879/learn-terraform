variable "Public_subnet_cidr" {
    type = list(string)
    description = "Public Subnet CIDR values"
    default = [ "10.0.1.0/24", "10.0.2.0/24" ]
  
}


variable "Private_subnet_cidr" {
    type = list(string)
    description = "Private Subnet CIDR values"
    default = [ "10.0.3.0/24", "10.0.4.0/24" ]
  
}


