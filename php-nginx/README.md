
# PHP + Nginx Dockerized Deployment with Terraform and Ansible

This project demonstrates how to deploy a **PHP + Nginx** application using **Docker Compose**, provisioned with **Terraform** and configured using **Ansible**. The infrastructure is created on AWS.

---

## Project Structure

```
project/
├── ansible/
│   ├── dynamic_inventory.sh  # Dynamic inventory script
│   ├── playbook.yml          # Main playbook to deploy the application
│   ├── roles/
│   │   ├── docker/           # Role for Docker and Docker Compose setup
│   │   │   ├── tasks/        # Task files for setting up Docker services
│   │   │   │   └── main.yml  # Main task file
│   │   │   ├── files/        # Static files (Dockerfile, Nginx config, etc.)
│   │   │   │   ├── Dockerfile
│   │   │   │   ├── nginx.conf
│   │   │   │   └── docker-compose.yml
├── terraform/
│   ├── main.tf               # Terraform configuration for AWS resources
│   ├── outputs.tf            # Terraform outputs for Ansible inventory
│   ├── variables.tf          # Terraform variables definition
│   ├── terraform.tfvars      # Terraform variable values
```

---

## Prerequisites

1. **Terraform**: Install Terraform [here](https://www.terraform.io/downloads).
2. **Ansible**: Install Ansible [here](https://docs.ansible.com/ansible/latest/installation_guide/index.html).
3. **AWS CLI**: Configure AWS CLI with credentials and region.
4. **SSH Key Pair**: Ensure the key pair (`your-key-name`) is available for the AWS instances.

---

## Setup Instructions

### 1. Clone the Repository

```bash
git clone <repository-url>
cd project
```

### 2. Deploy Infrastructure with Terraform

1. Navigate to the `terraform` directory:
   ```bash
   cd terraform
   ```
2. Initialize Terraform:
   ```bash
   terraform init
   ```
3. Apply the Terraform configuration:
   ```bash
   terraform apply
   ```
   - Terraform will provision an AWS EC2 instance for the application.:q!

### 3. Deploy Application with Ansible

1. Navigate to the project root:
   ```bash
   cd ../ansible
   ```
2. Run the Ansible playbook:
   ```bash
   ansible-playbook -i dynamic_inventory.sh playbook.yml
   ```

---

## Application Access

- Once the deployment is complete, access the application in a browser at:
  ```
  http://<dockerhost_public_ip>:8080
  ```
  Replace `<dockerhost_public_ip>` with the public IP output from Terraform.
:q
---

## Files Overview

### Terraform

- **`main.tf`**: Provisions AWS EC2 instances and triggers Ansible playbook.
- **`outputs.tf`**: Outputs instance IP for Ansible inventory.
- **`variables.tf`**: Defines reusable variables.

### Ansible

- **`playbook.yml`**: Deploys the PHP + Nginx application using Docker Compose.
- **Roles**:
  - **`docker/tasks/main.yml`**: Installs Docker, Docker Compose, and deploys the app.
  - **`docker/files/`**: Contains application files like `Dockerfile` and `nginx.conf`.

---

## Cleanup

To destroy the infrastructure:
```bash
terraform destroy
```

---

## Author

This project was created for demonstrating Infrastructure as Code (IaC) with Terraform and Ansible.

---

Feel free to customize this README based on your needs!
