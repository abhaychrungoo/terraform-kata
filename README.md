## Synopsis

A prepared kata to demonstrate fully automated Infrastructure provisioning and application (re)deployment. We will deploy a simple go application on multiple nodes behind a nginx based load balancer using terraform and ansible. We will also enable quick redeployment with dynamic inventory discovery.

## Using

Setup the PreRequisites

copy operations/terraform/terraform.tfvars.sample to operations/terraform/terraform.tfvars and supply the aws credentials.

```./run
```

## Refernce

### Provision the aws infrastructure
```bash
./deploy_infra
```

### Deploy the application stack for any application code changes
```bash
./deploy_stack
```

### Cleanup all aws resources. Destroy the environment
```./cleanup
```
## Pre-Requisites

Install [Terraform](https://www.terraform.io/intro/getting-started/install.html) and make it available on the path.  
Install [Ansible](http://docs.ansible.com/ansible/intro_installation.html)  and make it available on the path.  
Install [terraform-inventory](https://github.com/adammck/terraform-inventory) and make it available on the path.  
```pip install boto
``` 

## Tests

Run a simple test to hit the loadbalancer 10 times
```bash
./test
```

## License

Freeware
