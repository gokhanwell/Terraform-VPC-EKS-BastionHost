variable "region" {
  default = "us-east-1"

}
variable "vpc_cidr_block" {
  default = "10.0.0.0/16"
}

variable "public_subnet_1_cidr_block" {
  default = "10.0.1.0/24"
}

variable "public_subnet_2_cidr_block" {
  default = "10.0.2.0/24"
}

variable "public_subnet_3_cidr_block" {
  default = "10.0.3.0/24"
}

variable "private_subnet_1_cidr_block" {
  default = "10.0.5.0/24"
}

variable "private_subnet_2_cidr_block" {
  default = "10.0.6.0/24"
}

variable "private_subnet_3_cidr_block" {
  default = "10.0.7.0/24"
}

variable "ec2_name" {
  default = "Terraform-Bastion-Host"
}

variable "ec2_type" {
  default = "t2.micro"
}

variable "ec2_ami" {
  default = "ami-0261755bbcb8c4a84"
}

variable "key_name" {
  default = "XXXXXXXXXX"
}

variable "access_key" {
  default = "XXXXXXXXXXX"
}

variable "secret_access_key" {
  default = "XXXXXXXXXXX"
}
