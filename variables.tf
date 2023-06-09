variable "vpc_cidr" {
  type    = string
  default = "10.0.0.0/16"
}

variable "subnet1_cidr" {
  type        = string
  description = "Subnet 1 cidr block"
  default     = "10.0.1.0/24"
}

variable "subnet2_cidr" {
  type        = string
  description = "Subnet 2 cidr block"
  default     = "10.0.2.0/24"
}

variable "subnet3_cidr" {
  type        = string
  description = "Subnet 3 cidr block"
  default     = "10.0.3.0/24"
}

variable "subnet4_cidr" {
  type        = string
  description = "Subnet 4 cidr block"
  default     = "10.0.4.0/24"
}

variable "route_table_cidr" {
  type        = string
  description = "cidr block for public route table"
  default     = "0.0.0.0/0"
}

variable "ami_id" {
  type        = string
  description = " AMI ID"
  default     = "ami-09988af04120b3591"
}

variable "instance_type" {
  type        = string
  description = "The instance type"
  default     = "t2.micro"
}