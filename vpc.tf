
data "aws_vpc" "existing_ce9_vpc" {
 filter {
   name   = "tag:Name"
   values = [var.vpc_name]
 }
}


data "aws_subnet" "existing_ce9_pub_subnet1" {
 filter {
   name   = "tag:Name"
   values = [var.subnet_name1]
 }
}
data "aws_subnet" "existing_ce9_pub_subnet2" {
 filter {
   name   = "tag:Name"
   values = [var.subnet_name2]
 }
}

data "aws_ami" "amazon2023" {
    filter {
        name = "name"
        values = ["amzn2-ami-kernel-5.10-hvm-2.0.20250116.0-x86_64-gp2"]
    }

    filter {
        name = "virtualization-type"
        values = ["hvm"]
    }
}