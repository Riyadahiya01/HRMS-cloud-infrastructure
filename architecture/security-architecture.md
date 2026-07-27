# Security Architecture

## Overview

The HRMS + Employee Portal follows the AWS Shared Responsibility Model and applies security best practices to protect application resources, user data, and employee documents.

The architecture is designed using the principle of least privilege, network isolation, and secure communication between AWS services.

---

# Design Objectives

The security architecture is designed to achieve the following objectives:

- Protect application resources from unauthorized access
- Restrict communication using Security Groups
- Secure sensitive information using AWS Secrets Manager
- Prevent direct access to the database
- Use IAM Roles instead of long-term access keys
- Encrypt employee documents stored in Amazon S3

---

# Application Load Balancer Security

The Application Load Balancer (ALB) is the only internet-facing resource.

## Security Group

**SG-ALB**

### Inbound Rules

| Protocol | Port | Source |
|----------|------|--------|
| HTTPS | 443 | Internet (0.0.0.0/0) |

### Outbound Rules

| Protocol | Destination |
|----------|-------------|
| HTTP / HTTPS | Amazon EC2 (SG-EC2) |

The ALB receives client requests and forwards them to the application server.

---

# EC2 Security

The Node.js backend runs on Amazon EC2.

## Security Group

**SG-EC2**

### Inbound Rules

| Protocol | Port | Source |
|----------|------|--------|
| HTTP | 80 | SG-ALB |

### Outbound Rules

| Protocol | Destination |
|----------|-------------|
| PostgreSQL (5432) | Amazon RDS |
| HTTPS (443) | Amazon S3 |
| HTTPS (443) | AWS Secrets Manager |
| HTTPS (443) | Amazon CloudWatch |

The EC2 instance is not directly accessible from the internet.

---

# Database Security

Amazon RDS PostgreSQL stores the application data.

## Security Group

**SG-RDS**

### Inbound Rules

| Protocol | Port | Source |
|----------|------|--------|
| PostgreSQL | 5432 | SG-EC2 |

### Outbound Rules

Default return traffic only.

The database remains isolated and cannot be accessed directly from the internet.

---

# IAM Role

An IAM Role is attached to the EC2 instance.

Permissions include:

- Read and write access to Amazon S3
- Read access to AWS Secrets Manager
- Publish logs and metrics to Amazon CloudWatch

No AWS access keys are stored on the EC2 instance.

---

# AWS Secrets Manager

Sensitive information is securely stored in AWS Secrets Manager.

Examples include:

- Database Username
- Database Password
- JWT Secret
- Application Secrets

Application secrets are retrieved securely at runtime.

---

# Amazon S3 Security

Amazon S3 stores employee documents uploaded through the HRMS application.

Security features include:

- IAM Role-based access
- Server-side encryption
- Secure HTTPS communication
- Private bucket access

Only the application server can upload or download employee documents.

---

# Security Communication Flow

Application requests follow this secure communication path:

Internet

↓

Application Load Balancer

↓

Amazon EC2

↓

Amazon RDS PostgreSQL

Amazon EC2 also securely communicates with:

- Amazon S3
- AWS Secrets Manager
- Amazon CloudWatch

---

# Security Principles

The architecture follows these AWS security best practices:

- Least Privilege Access
- HTTPS-only communication
- Security Group-based access control
- IAM Roles instead of Access Keys
- No Public Database
- Secure Secret Management
- Encrypted Object Storage
- Network Isolation

---

# AWS Shared Responsibility Model

AWS is responsible for:

- Physical security
- Data centers
- Networking infrastructure
- Managed service availability

The customer is responsible for:

- IAM permissions
- Security Groups
- Application security
- Data protection
- Operating system updates
- Secrets management

---

# Design Summary

The security architecture provides:

- Secure internet access through the Application Load Balancer
- Restricted access using Security Groups
- Private database deployment
- Secure IAM Role authentication
- Protected application secrets
- Encrypted employee document storage
- Production-inspired AWS security design