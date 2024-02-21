#!/bin/bash 
# Только для отладки, по инструкции не используется

# Add yandex env vars
export YC_TOKEN=$(yc iam create-token)
export YC_CLOUD_ID=$(yc config get cloud-id)
export YC_FOLDER_ID=$(yc config get folder-id)

# VM creation 
terraform init
terraform apply --auto-approve 

# Grab external ip 
external_ip=$(terraform apply --auto-approve --refresh-only | grep vulnbox_external_ip| awk -F'"' '{print $2}')
ansible_ip=$(echo $external_ip,)

# Run ansible playbook
export ANSIBLE_HOST_KEY_CHECKING=False
ansible-playbook -u admin --private-key ~/.ssh/id_rsa --ssh-common-args='-o StrictHostKeyChecking=no' provision.yml -i $ansible_ip 