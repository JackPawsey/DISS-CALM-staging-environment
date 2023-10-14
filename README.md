# DISS-CALM-staging-environment
Final year uni dissertation

Uses the CALM Terraform module and ansible to provision an observability stack in an AWS account

## Usage
S3 backend DynamoDB table and S3 bucket name should match those created by Terraform remote state backend

AWS account keys need to be supplied via CI pipeline environment

## About
Terraform backend: https://github.com/JackPawsey/DISS-CALM-terraform-backend  
Terraform module: https://github.com/JackPawsey/DISS-CALM-terraform-module  
Ansible: https://github.com/JackPawsey/DISS-CALM-ansible
