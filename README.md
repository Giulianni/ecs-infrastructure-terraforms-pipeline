# ECS Training Repository

This repository is designed to provide training and hands-on experience with deploying applications to AWS ECS using Terraform and GitLab CI/CD. It includes a structured Git branching strategy, Terraform configurations, and CI/CD pipeline automation.

---

## Table of Contents

1. [Git Branching Strategy](#git-branching-strategy)
2. [Repository Overview](#repository-overview)
3. [Terraform Infrastructure](#terraform-infrastructure)
4. [CI/CD Pipeline](#cicd-pipeline)
5. [How to Use](#how-to-use)
6. [Notes](#notes)

---

## 1. Git Branching Strategy

We will use a modified Git Flow:

- **Main branch**: Contains the stable and production-ready version.
- **Develop branch**: The main branch for integrating new functionality.
- **Feature branches**: (`feature/new-feature`) Used for developing new features.
- **Release branches**: (`release/v1.x.x`) Used for final testing and preparation before merging into the main branch. If issues are found during this phase, a specific branch (`fix/bug-x`) will be created to resolve the issue and merge it back into the release branch.
- **Hotfix branches**: (`hotfix/bug-fix`) Used to fix critical errors in production.

---

## 2. Repository Overview

This repository contains the following components:

- **Terraform Configurations**: Infrastructure as Code (IaC) for provisioning AWS resources such as ECS, ECR, IAM roles, and networking.
- **CI/CD Pipeline**: A GitLab CI/CD pipeline for automating the build, deployment, and infrastructure provisioning process.
- **Documentation**: Instructions and guidelines for using the repository effectively.

---

## 3. Terraform Infrastructure

The Terraform configurations are organized into reusable modules and environment-specific configurations. Below is the directory structure:

```plaintext
infra/
├── .terraform/          # Terraform state and provider files
├── environments/        # Environment-specific configurations
├── modules/             # Reusable Terraform modules 
├── outputs.tf           # Output values from Terraform
├── provider.tf          # Provider configuration
├── terraform.tfvars     # Default variable values
├── variables.tf         # Input variables for Terraform

---
## How to Use Terraform

1. Navigate to the desired environment (e.g., infra/environments/dev).

2. Initialize Terraform:
´´´
terraform init
´´´
3. Plan the infrastructure changes:
´´´
terraform plan
´´´

4. Apply the changes:
´´´
terraform apply
´´´

## 4. CI/CD Pipeline

The repository includes a GitLab CI/CD pipeline defined in `.gitlab-ci.yml`. The pipeline automates the following stages:

### Build and Push Image:
- Builds a Docker image using Kaniko.
- Pushes the image to Amazon ECR.

### Trigger Terraform:
- Triggers a Terraform pipeline to provision or update the infrastructure.

### Verify Terraform Pipeline:
- Monitors the Terraform pipeline's status and ensures successful execution.

### Deploy to ECS:
- Updates the ECS service to use the new Docker image.

---

## Environment Variables

Ensure the following environment variables are configured in GitLab CI:

- `AWS_ACCOUNT_ID`
- `AWS_REGION`
- `ECR_REPOSITORY_NAME`
- `TERRAFORM_TRIGGER_TOKEN`
- `TERRAFORM_PROJECT_ID`
- `GITLAB_API_TOKEN`
- `ECS_CLUSTER_NAME`
- `ECS_SERVICE_NAME`

---

## 5. How to Use

1. Clone the repository:
   ```bash
   git clone <repository-url>
   cd ecs_training