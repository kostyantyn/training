#
# DO NOT DELETE THESE LINES!
#
# Your AMI ID is:
#
#     ami-a4f9f2c2
#
# Your subnet ID is:
#
#     subnet-9a479ed3
#
# Your security group ID is:
#
#     sg-00100979
#
# Your Identity is:
#
#     hdays-michel-wombat
#
variable "aws_access_key" {
  type = "string"
}

variable "aws_secret_key" {
  type = "string"
}

variable "aws_region" {
  type = "string"

  default = "eu-west-1"
}

variable "num_webs" {
  default = 2
}

terraform {
  backend "atlas" {
    name = "kostiantyn/training"
  }
}

provider "aws" {
  access_key = "${var.aws_access_key}"
  secret_key = "${var.aws_secret_key}"
  region     = "${var.aws_region}"
}

resource "aws_instance" "web" {
  count                  = "${var.num_webs}"
  ami                    = "ami-a4f9f2c2"
  instance_type          = "t2.micro"
  subnet_id              = "subnet-9a479ed3"
  vpc_security_group_ids = ["sg-00100979"]

  tags {
    "Identity" = "hdays-michel-wombat"
    "Mytag"    = "kostia"
    "Name"     = "web ${count.index+1}/${var.num_webs}"
  }
}

# module "example" {
#  source = "./example-module"
#  command = "echo 'Goodbye'"
# }

output "public_dns" {
  value = ["${aws_instance.web.*.public_dns}"]
}

output "public_ip" {
  value = ["${aws_instance.web.*.public_ip}"]

