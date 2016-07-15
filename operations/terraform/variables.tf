## AWS 
variable "aws_access_key" {}
variable "aws_secret_key" {}
variable "aws_region" {
	default = "us-east-1"
}
variable "ami" {
        default = {
                us-east-1 = "ami-6869aa05"
        }
}

## A Simple Namespace.
variable "env" {
	default = "dev"
}
variable "topscope" {
	description = "Namespace for the AWS environemnt. Perhaps your project name. Or a feature. "
}

## Access Control
variable "whitelisted_ssh_cidr" {
	description = "Single CIDR block that will have ssh access to the cluster. 0.0.0.0/0  enables all"
	default = "0.0.0.0/0"
}

