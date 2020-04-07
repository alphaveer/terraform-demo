variable "name" {
  default = "terraform"
}

variable "vpc_cidr" {
  default = "10.1.0.0/16"
}

variable "subnet_offset" {
  default = 8
}

variable "number_of_azs" {
  default = 2
}

variable "nat_per_az" {
  default = true
}
