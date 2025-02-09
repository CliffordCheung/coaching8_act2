variable "vpc_name" {
 description = "The VPC Name to use"
 type        = string
 default     = "ce9-coaching-shared-vpc"
}


variable "subnet_name1" {
 description = "The VPC Name to use"
 type        = string
 default     = "ce9-coaching-shared-vpc-public-us-east-1a"
}

variable "subnet_name2" {
 description = "The VPC Name to use"
 type        = string
 default     = "ce9-coaching-shared-vpc-public-us-east-1b"
}