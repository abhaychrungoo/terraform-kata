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
variable "env" {
	default = "dev"
}
variable "target_webapps" {}
variable "key_name" {}
variable "security_group" {}
## Behavior

provider "aws" {
 access_key = "${var.access_key}"
 secret_key = "${var.secret_key}"
 region = "${var.region}"
}

resource "aws_instance" "standalone" {
 ami = "${lookup(var.ami, var.region)}"
 instance_type = "${var.instance_type}"
 key_name = "${var.key_name}"
 security_groups = ["${var.security_group}"]
 tags = {
         role = "loadbalancer"
         env  = "${var.env}"
 }
 provisioner "local-exec" {
 command = "sleep 40 && export ANSIBLE_HOST_KEY_CHECKING=False && ansible-playbook -i ${aws_instance.standalone.public_ip}, -u ec2-user -b --key-file ../keys/id_rsa --extra-vars='{\"target_webapps\":[\"${element(split(",",var.target_webapps),1)}:8484\",\"${element(split(",",var.target_webapps),0)}:8484\"]}' ../ansible/loadbalancer_provisioner.yml"
 }

}

## Output Contract

output public_ip {
	value = "${aws_instance.standalone.public_ip}"
}
