#!/bin/bash

# Navigate to the Terraform directory
cd ../terraform

# Fetch Terraform outputs in JSON format
TF_OUTPUT=$(terraform output -json)

# Extract the dockerhost IP
DOCKERHOST_IP=$(echo "$TF_OUTPUT" | jq -r '.dockerhost_ip.value')

# Define the output file path
INVENTORY_FILE="../ansible/inventory.ini"

# Generate inventory and save it to the file
cat <<EOF > "$INVENTORY_FILE"
[docker]
dockerhost ansible_host=${DOCKERHOST_IP} ansible_user=ec2-user ansible_ssh_private_key_file=~/.ssh/won_ls_key.pem
EOF

# Optional: Print a success message
echo "Inventory file generated and saved at $INVENTORY_FILE"
