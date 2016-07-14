# AWS Provider
provider "aws" {
 access_key = "${var.access_key}"
 secret_key = "${var.secret_key}"
 region = "${var.region}"
}

resource "aws_instance" "LoadBalancer" {
 ami = "${lookup(var.lb_ami, var.region)}"
 instance_type = "${var.lb_instance_type}"
}

