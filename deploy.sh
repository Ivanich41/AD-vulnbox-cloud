#!/bin/bash 
# VM creation 
terraform init
terraform apply --auto-approve 

# Grab external ip 
external_ip=$(terraform apply --auto-approve --refresh-only | grep vulnbox_external_ip| awk -F'"' '{print $2}')
ansible_ip=$(echo $external_ip,)

# Run ansible playbook
ansible-playbook -u admin -i $ansible_ip --private-key ~/.ssh/id_rsa provision.yml