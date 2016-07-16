
module "ec2_loadbalancer" {
	source = "./modules/ec2_loadbalancer"
	access_key = "${var.aws_access_key}"
	secret_key = "${var.aws_secret_key}"
	region = "${var.aws_region}"
	env = "${var.env}"
	key_name = "${module.ec2_networking.ssh_key_name}"
	security_group = "${module.ec2_networking.security_group_public}"
	target_webapps = "${module.ec2_webapp.private_ips}"
}
module "ec2_webapp" {
	source = "./modules/ec2_webapp"
	count = 2
	access_key = "${var.aws_access_key}"
	secret_key = "${var.aws_secret_key}"
	region = "${var.aws_region}"
	env = "${var.env}"
	key_name = "${module.ec2_networking.ssh_key_name}"
	security_group = "${module.ec2_networking.security_group_private}"
}	

module "ec2_networking" {
	topscope = "${var.topscope}"
	source = "./modules/ec2_networking"
	access_key = "${var.aws_access_key}"
	secret_key = "${var.aws_secret_key}"
        public_key = "${file("${path.root}/../keys/id_rsa.pub")}"
	region = "${var.aws_region}"
	env = "${var.env}"
	whitelisted_ssh_cidr = "${var.whitelisted_ssh_cidr}"

}

output "webapp_private_ips" {
	value = "${module.ec2_webapp.private_ips}"
}
output "webapp_public_ips" {
	value = "${module.ec2_webapp.public_ips}"
}

output "loadbalancer_ip" {
	value = "${module.ec2_loadbalancer.public_ip}"
}
