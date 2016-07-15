## All in one variables resources and outputs.
## Breakdown if it gets too complex


## Input Contract
variable "access_key" {}
variable "secret_key" {}
variable "whitelisted_ssh_cidr" {}
variable "region" {
        default = "us-east-1"
}

variable "env" {
        default = "dev"
}
variable "topscope" {} 

provider "aws" {
 access_key  = "${var.access_key}"
 secret_key  = "${var.secret_key}"
 region      = "${var.region}"
}

resource "aws_key_pair"  "kata_key_pair" {
	key_name = "${var.topscope}_${var.env}_kata"
#	public_key = "${file("${path.root}/../keys/ida_rsa.pub")}"
	public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCXWwxMLZiXhjn2srqu2PChZcIZV63Kej0SU3dggR6i4sbDY+4mHcx0VVZojoj4Xy2NcW01a3m0rDEsxCQVb+nUfv3Eru+40FLUg+KJd18hMugmD10wtPPcN8u50tJU+2txzREZrG3dRvOarOK5vM1k0Vn4mGX5U8suCCQifqHBj0whGaMXzHOqCvnak5EFELa7thDx2nGBsQQtLLndpHnyejjbgs/NZFVXleiDym39fHcjl0QzoZEO/veZMLQmVlpqI7kzexWP2RdCZskaMU+6NVlMCZzmJ7ANbnPv5B2MRwT7Ulj8eOEA/Qh/doeXSfhLycc0oWmEeY9BvVliCHLN"
}

resource "aws_security_group" "public_loadbalancer"{
    name = "${var.topscope}_${var.env}_loadbalancer"
    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["${var.whitelisted_ssh_cidr}"]
    }
    ingress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
}
resource "aws_security_group" "private_application"{
    name = "${var.topscope}_${var.env}_application"
    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["${var.whitelisted_ssh_cidr}"]
    }
    ingress {
        from_port = 0
        to_port = 0
        protocol = "-1"
	security_groups = ["${aws_security_group.public_loadbalancer.id}"]
    }
    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
}

## Output Contract
output "ssh_key_name" {
	value = "${var.topscope}_${var.env}_kata"
}
output "security_group_public" {
	value = "${aws_security_group.public_loadbalancer.name}"
}
output "security_group_private" {
	value = "${aws_security_group.private_application.name}"
}
