#!/bin/bash 
# Только для отладки, по инструкции не используется

# Add yandex env vars
export YC_TOKEN=$(yc iam create-token)
export YC_CLOUD_ID=$(yc config get cloud-id)
export YC_FOLDER_ID=$(yc config get folder-id)

terraform destroy --auto-approve 
rm -f terraform.tfstate terraform.tfstate.backup .terraform.lock.hcl