locals {
 name_prefix = "clifford"
}


resource "aws_iam_role" "role_example" {
 name = "${local.name_prefix}-role-coaching8-2"


 assume_role_policy = jsonencode({
   Version = "2012-10-17"
   Statement = [
     {
       Action = "sts:AssumeRole"
       Effect = "Allow"
       Sid    = ""
       Principal = {
         Service = "ec2.amazonaws.com"
       }
     },
   ]
 })
}


data "aws_iam_policy_document" "policy_example" {
 statement {
   effect    = "Allow"
   actions   = ["ec2:Describe*"]
   resources = ["*"]
 }
 statement {
   effect    = "Allow"
   actions   = ["s3:ListBucket"]
   resources = ["*"]
 }
}


resource "aws_iam_policy" "policy_example" {
 name = "${local.name_prefix}-policy-coaching8-2"


 ## Option 1: Attach data block policy document
 policy = data.aws_iam_policy_document.policy_example.json


}


resource "aws_iam_role_policy_attachment" "attach_example" {
 role       = aws_iam_role.role_example.name
 policy_arn = aws_iam_policy.policy_example.arn
}


resource "aws_iam_instance_profile" "profile_example" {
 name = "${local.name_prefix}-profile-coaching8-2"
 role = aws_iam_role.role_example.name
}

resource "aws_instance" "public" {
 ami                         = "ami-0df8c184d5f6ae949" #Challenge, find the AMI ID of Amazon Linux 2 in us-east-1
 instance_type               = "t2.micro"
 subnet_id                   = data.aws_subnet.existing_ce9_pub_subnet1.id
 associate_public_ip_address = true
 key_name                    = "clifford_keypair_1218" #Change to your keyname, e.g. jazeel-key-pair
 iam_instance_profile        = aws_iam_instance_profile.profile_example.id
 vpc_security_group_ids = [aws_security_group.allow_ssh.id]
 tags = {
   Name = "${local.name_prefix}-coaching8-2-ec2" # Ensure your
 }
}


output "ec2_public_ip" {
 value = aws_instance.public.public_ip
}


resource "aws_security_group" "allow_ssh" {
 name        = "${local.name_prefix}-security-group-coaching8-2"
 description = "Allow SSH inbound"
 vpc_id      = data.aws_vpc.existing_ce9_vpc.id

  ingress {
   description = "HTTPS ingress"
   from_port   = 443
   to_port     = 443
   protocol    = "tcp"
   cidr_blocks = ["0.0.0.0/0"]
 }
 ingress {
   description = "SSH ingress"
   from_port   = 22
   to_port     = 22
   protocol    = "tcp"
   cidr_blocks = ["0.0.0.0/0"]
 }
 ingress {
   description = "RDS ingress"
   from_port   = 3306
   to_port     = 3306
   protocol    = "tcp"
   cidr_blocks = ["0.0.0.0/0"]
 }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
