# Raspberry Pi 5 Edge and Amazon EKS Lab

## Project goal

Build a beginner-friendly edge computing and cloud automation
portfolio using Raspberry Pi 5, Raspberry Pi OS, AWS, Kubernetes,
and Terraform.

## Environment

- Edge device: Raspberry Pi 5
- Operating system: Raspberry Pi OS (64-bit)
- CPU architecture: ARM64 / aarch64
- Cloud provider: AWS
- Kubernetes service: Amazon EKS
- Infrastructure as code: Terraform
- Kubernetes CLI: kubectl

## Project status

- [x] Raspberry Pi OS retained
- [x] AWS CLI configured
- [x] kubectl installed
- [x] Existing EKS cluster reachable
- [x] GitHub repository initialized
- [x] Verify EKS hybrid networking prerequisites
- [x] Document architecture and networking
- [x] Add Terraform configuration
- [x] Deploy a test workload
- [x] Add edge monitoring and automation

## Important compatibility note

Raspberry Pi OS is used for development and edge-device tasks.
Direct EKS Hybrid Node registration must not be assumed to work
on Raspberry Pi OS. Validate the operating system, processor,
networking, credentials, and EKS requirements before attempting
hybrid-node registration.

## Cost and safety

Inspect existing AWS resources before creating or changing them.
Terraform plans must be reviewed before applying changes.
Do not commit AWS credentials, private keys, Terraform state,
or files containing secrets.
