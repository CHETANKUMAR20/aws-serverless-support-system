# 🚀 AWS Serverless Support System

![AWS](https://img.shields.io/badge/AWS-Serverless-orange)
![Terraform](https://img.shields.io/badge/IaC-Terraform-blue)
![Node.js](https://img.shields.io/badge/Runtime-Node.js-green)
![DynamoDB](https://img.shields.io/badge/Database-DynamoDB-lightgrey)
![API Gateway](https://img.shields.io/badge/API-HTTP%20API-yellow)
![Status](https://img.shields.io/badge/Project-Completed-brightgreen)

🚀 AWS Serverless Support System
📌 Project Overview

A production-grade, modular AWS Serverless backend built using:

API Gateway (HTTP API)

AWS Lambda (Node.js 18)

DynamoDB (On-demand)

IAM (Least Privilege)

Terraform (Modular, Multi-environment)

Remote Backend (S3 + DynamoDB Locking)

🏗 Architecture

Client → API Gateway → Lambda → DynamoDB

Infrastructure managed using Terraform modules.

📁 Project Structure
environments/
modules/
lambda-app/
bootstrap/

modules/ – Reusable Terraform modules

environments/ – Dev & Prod isolation

lambda-app/ – Clean architecture Lambda code

bootstrap/ – Remote backend setup

🔐 Security Features

IAM Least Privilege

Remote State Locking

S3 Public Access Blocked

Point-in-time recovery enabled

X-Ray Tracing

Tagged resources

⚙ Deployment Steps
1️⃣ Bootstrap Backend
```
cd bootstrap
terraform init
terraform apply
```
2️⃣ Deploy Dev Environment
```
cd environments/dev
terraform init
terraform apply
```
🧪 API Endpoints
Create Ticket

POST /tickets

Get Ticket

GET /tickets/{id}

🧠 Challenges Faced During Development

Runtime.ImportModuleError

Cause: AWS SDK not bundled in Node 18 runtime

Fix: Installed aws-sdk inside lambda-app and repackaged

Terraform Module Wiring Errors

Missing variable definitions

Incorrect resource references

Fixed by properly defining module variables

Remote Backend Initialization Failure

Cause: S3 bucket not created before environment init

Fix: Bootstrap phase applied first

Incorrect ZIP Packaging

Lambda handler not found

Fixed by zipping from inside lambda-app directory

💰 Cost Model

Fully Serverless

Pay-per-request architecture

No always-running services

Cost-optimized design

📸 Screenshots

See /docs/screenshots/ for proof of deployment.


