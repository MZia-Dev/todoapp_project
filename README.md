🌟** TodoApp Project — Modular Terraform Azure Infrastructure (Prod/Dev)

A fully modular, production‑ready Terraform project that deploys a complete Azure environment for a two‑tier Todo Application. This repository follows real‑world DevOps and IaC best practices, featuring reusable modules, multi‑environment structure, automated security scanning, and CI/CD integration using Azure DevOps Pipelines.

🚀 Project Overview

This project provisions a secure and scalable Azure infrastructure using Terraform modules.It deploys two Linux VMs (Frontend + Backend) in the prod environment and supports a parallel dev environment for testing.

The architecture includes:

Resource Group

Virtual Network (VNet)

Subnets

Network Security Groups (NSG)

NIC + NSG Association

Public IP

Linux Virtual Machines

Modular folder structure for reusability

🧱 Terraform Modules

Each Azure resource is built as a reusable module:

modules/
│── resource_group
│── vnet
│── subnet
│── nsg
│── nic
│── nic_nsg_association
│── public_ip
│── linux_vm

Environments:

environment/
│── prod/
│── dev/

🔐 DevSecOps Security Scanning

The Azure DevOps pipeline automatically runs multiple security and quality checks:

✔ TFLint

Terraform linting & best practices

✔ tfsec

Terraform security scanning

✔ Checkov

IaC misconfiguration & compliance scanning

✔ Terratest

Go‑based automated infrastructure testing

This ensures the infrastructure is secure, compliant, and production‑grade before deployment.

⚙️ Azure DevOps Pipeline (CI/CD)

The pipeline performs:

Terraform formatting

TFLint

tfsec

Checkov

Terratest

Terraform plan

Manual approval

Terraform apply

This enforces a complete DevSecOps workflow.

🏗️ Architecture Summary

Two‑tier VM deployment (Frontend + Backend)

Isolated prod/dev environments

Secure networking with NSGs

Modular, reusable Terraform code

Automated testing + scanning

Azure DevOps CI/CD integration

📦 Tech Stack

Terraform

Azure

Azure DevOps Pipelines

TFLint

tfsec

Checkov

Terratest (Go)

🎯 Purpose

This project demonstrates:

Real‑world Terraform module design

Multi‑environment IaC structure

DevSecOps automation

Azure VM‑based application hosting

Production‑grade infrastructure patterns

Perfect for learning, portfolio showcase, or enterprise‑level deployments.

If you want, I can also create:

A pipeline YAML file

A diagram (ASCII or Mermaid)

A contribution guide

A module‑by‑module explanation
