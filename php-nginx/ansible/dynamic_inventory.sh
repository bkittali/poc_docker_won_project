#!/bin/bash

# Fetch Terraform outputs in JSON format
TF_OUTPUT=$(terraform output -json)

# Extract the dockerhost IP
DOCKERHOST_IP=$(echo "$TF_OUTPUT" | jq -r '.dockerhost_ip.value')

# Generate inventory
cat <<EOF
[docker]
dockerhost ansible_host=${DOCKERHOST_IP} ansible_user=ec2-user ansible_ssh_private_key_file=~/.ssh/your-key.pem
EOF
