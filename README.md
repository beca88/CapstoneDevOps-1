# SIT DevOps Capstone Project 🚀

**Southern Institute of Technology (SIT) - Bachelor of Information Technology**

This repository contains the code, configuration, and documentation for our final DevOps capstone project. The project demonstrates a modern, end-to-end cloud-native deployment lifecycle on Microsoft Azure, adhering to industry best practices and NIST cloud security frameworks.

## 👥 Team Members
* **Beste** - Cloud Infrastructure & Environments
* **Blake** - Architecture & Docker DevOps Engineer
* **Rebecca** - [Add Role]

## 🎯 Project Overview
In today’s fast-paced deployment environments, organizations require highly automated, secure, and scalable infrastructure. This project serves as a comprehensive DevOps solution that modernizes application delivery. We are provisioning scalable cloud infrastructure on Microsoft Azure using Infrastructure as Code (IaC), containerizing an application, and establishing a fully automated continuous integration and continuous deployment (CI/CD) pipeline.

## 🏗️ Project Scope & Architecture
Our solution covers the following core deliverables:

1. **Cloud Infrastructure Hosted on Azure:** A secure base network utilizing Azure Resource Groups and Virtual Networks.
2. **Infrastructure as Code (IaC):** Automated provisioning of all cloud resources using HashiCorp **Terraform**.
3. **Containerized Application:** A sample application packaged efficiently using **Docker** and stored in Azure Container Registry (ACR).
4. **Kubernetes Deployment (AKS):** Highly available container orchestration using Azure Kubernetes Service.
5. **CI/CD Pipeline:** Fully automated build and release lifecycle managed via **Azure DevOps YAML** pipelines.
6. **Security & Monitoring:** Integration of Azure Monitor, Log Analytics, and secure credential management to ensure operational resilience.

## 🛠️ Technology Stack
* **Cloud Platform:** Microsoft Azure (Azure for Students)
* **Development Environment:** Azure Cloud Shell (Bash) / Fedora Linux
* **Infrastructure as Code:** Terraform
* **Containerization:** Docker
* **Orchestration:** Kubernetes (AKS)
* **CI/CD:** Azure Pipelines
* **Version Control:** Git / GitHub

## 📂 Repository Structure
* `infrastructure/` - Contains all Terraform (`.tf`) files for Azure resource provisioning.
* `application/` - Contains the source code and `Dockerfile` for the sample application.
* `kubernetes/` - Contains the YAML deployment manifests for AKS.
* `pipelines/` - Contains the `azure-pipelines.yml` definitions for CI/CD.
* `docs/` - System architecture diagrams, meeting notes, and reflective evaluations.

---
*This repository was created as a graded academic assessment for the SIT IT program.*
