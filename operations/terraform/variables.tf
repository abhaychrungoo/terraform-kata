## AWS 
variable "access_key" {}
variable "secret_key" {}
variable "region" {
	default = "us-east-1"
}

## Nodes

## ## Load Balancer
variable "lb_ami" { 
	default = {
		us-east-1 = "ami-6869aa05"
	}
}
variable "lb_instance_type" {
	default = "t2.micro"
}
