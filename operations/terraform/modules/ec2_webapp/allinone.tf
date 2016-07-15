## All in one variables resources and outputs.
## Breakdown if it gets too complex


## Input Contract
variable "access_key" {}
variable "secret_key" {}
variable "region" {
	default = "us-east-1"
}

variable "ami" { 
	default = {
		us-east-1 = "ami-6869aa05"
	}
}
variable "instance_type" {
	default = "t2.micro"
}
variable "count" {
	default = 2
}
variable "env" {
	default = "dev"
}
variable "key_name" {}
variable "security_group" {}


## Behavior

provider "aws" {
 access_key = "${var.access_key}"
 secret_key = "${var.secret_key}"
 region = "${var.region}"
}

resource "aws_instance" "webapp" {
 ami = "${lookup(var.ami, var.region)}"
 instance_type = "${var.instance_type}"
 count = "${var.count}"
 key_name = "${var.key_name}"
 security_groups = ["${var.security_group}"]
 tags = {
         role = "webapp"
         env  = "${var.env}"
 }

# Post Provisioning
 provisioner "local-exec" {
 command = "sleep 40 && export ANSIBLE_HOST_KEY_CHECKING=False && ansible-playbook -i ${self.public_ip},  -u ec2-user -b --key-file ../keys/id_rsa ../ansible/webapp_provisioner.yml"
 }


}

## Output Contract

output public_ips{
	value = "${join(",", aws_instance.webapp.*.public_ip)}"
}
output private_ips {
	value = "${join(",", aws_instance.webapp.*.private_ip)}"
}
