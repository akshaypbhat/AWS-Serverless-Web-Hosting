# 🌐 Enterprise Serverless Web Ecosystem
**An automated, globally-distributed static hosting architecture built on AWS.**

![License](https://img.shields.io/badge/license-MIT-blue.svg)
![Terraform](https://img.shields.io/badge/terraform-1.0%2B-623ce4.svg)
![AWS](https://img.shields.io/badge/AWS-CloudFront%20%26%20S3-orange.svg)
![GitHub Actions](https://img.shields.io/badge/CI/CD-GitHub%20Actions-2088FF.svg)

## 📌 Overview
This project demonstrates a production-grade approach to hosting static web assets. Instead of a traditional server-based model, this architecture leverages **Amazon S3** for durable storage and **Amazon CloudFront** for global content delivery (CDN). 

The entire infrastructure is managed as code (**IaC**) using Terraform and deployed via an automated **CI/CD pipeline**.

## 🏗️ Architecture
The system follows the **"Least Privilege"** security model:
* **Storage:** Amazon S3 (Private Bucket).
* **CDN:** Amazon CloudFront with **Origin Access Control (OAC)** — ensuring the S3 bucket is not publicly accessible.
* **Security:** Forced HTTPS redirection and SSL/TLS encryption at the edge.
* **Deployment:** GitHub Actions pipeline for automated S3 synchronization and CloudFront cache invalidation.

## 🚀 Key Features
- **Zero-Server Management:** No EC2 instances to manage, patch, or scale.
- **Global Low Latency:** Content is served from the nearest AWS Edge Location (PoP).
- **Cost Optimized:** Utilizes the AWS Free Tier; pay-as-you-go pricing for high traffic.
- **Automated Workflow:** Continuous Deployment (CD) ensures that any change pushed to the `main` branch is live globally in minutes.

## 🛠️ Tech Stack
* **Infrastructure:** Terraform (HCL)
* **Cloud Provider:** Amazon Web Services (AWS)
* **CI/CD:** GitHub Actions
* **Frontend:** HTML5, CSS3, JavaScript

## 📖 How to Deploy
1. **Prerequisites:**
   * AWS CLI configured with appropriate IAM permissions.
   * Terraform installed locally.
2. **Initialize Infrastructure:**
   ```bash
   terraform init
   terraform plan
   terraform apply
