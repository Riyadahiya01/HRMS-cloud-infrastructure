# Network Routing

## Overview

The network routing architecture defines how traffic flows between the internet, public resources, private application resources, and the database layer inside the Amazon VPC.

The routing configuration follows AWS networking best practices by separating internet-facing traffic from internal application traffic while ensuring that private resources remain isolated.

---

# Design Objectives

The routing architecture is designed to achieve the following objectives:

- Secure internet access
- Network isolation
- Controlled outbound connectivity
- Protection of private resources
- Simple and scalable routing
- Production-inspired AWS network design

---

# Internet Gateway (IGW)

The Internet Gateway provides connectivity between the Amazon VPC and the public internet.

Responsibilities:

- Enables inbound HTTPS traffic to the Application Load Balancer.
- Enables outbound internet access for public resources.
- Acts as the target for the default route in the Public Route Table.

---

# Public Route Table

## Route Configuration

| Destination | Target |
|-------------|--------|
| 10.0.0.0/16 | Local |
| 0.0.0.0/0 | Internet Gateway |

## Associated Subnets

- Public Subnet 1
- Public Subnet 2

Purpose:

- Provides internet connectivity for public subnets.
- Routes inbound and outbound internet traffic through the Internet Gateway.

---

# NAT Gateway

The NAT Gateway is deployed in Public Subnet 1.

Purpose:

- Allows private application servers to download operating system updates and application packages.
- Prevents inbound internet access to private instances.

> **Note:** The architecture represents a production-inspired deployment. The Terraform implementation for this project will omit the NAT Gateway to remain within AWS Free Tier limits.

---

# Private Route Table

## Route Configuration

| Destination | Target |
|-------------|--------|
| 10.0.0.0/16 | Local |
| 0.0.0.0/0 | NAT Gateway |

## Associated Subnets

- App Private Subnet 1
- App Private Subnet 2

Purpose:

- Routes outbound traffic from private application servers.
- Prevents direct inbound internet access.

---

# Database Route Table

## Route Configuration

| Destination | Target |
|-------------|--------|
| 10.0.0.0/16 | Local |

There is **no default internet route** for the database layer.

## Associated Subnets

- DB Private Subnet 1
- DB Private Subnet 2

Purpose:

- Allows communication only within the VPC.
- Keeps the database isolated from the internet.

---

# Route Associations

| Route Table | Associated Resources |
|-------------|----------------------|
| Public Route Table | Public Subnet 1, Public Subnet 2 |
| Private Route Table | App Private Subnet 1, App Private Subnet 2 |
| Database Route Table | DB Private Subnet 1, DB Private Subnet 2 |

---

# Traffic Flow

## Public Traffic

Internet

↓

Internet Gateway

↓

Public Route Table

↓

Application Load Balancer

---

## Application Traffic

Application Load Balancer

↓

Amazon EC2

↓

Amazon RDS PostgreSQL

---

## Outbound Traffic

Amazon EC2

↓

Private Route Table

↓

NAT Gateway *(Production Design)*

↓

Internet

---

## Database Traffic

Amazon EC2

↓

Database Route Table

↓

Amazon RDS PostgreSQL

The database never communicates directly with the public internet.

---

# Security Considerations

The routing architecture follows these security principles:

- Public resources remain isolated from private resources.
- Application servers are not directly accessible from the internet.
- Database resources are completely isolated.
- Internet access is controlled through dedicated route tables.
- Private resources communicate internally using local routes.

---

# High Availability

The routing design supports:

- Multiple Availability Zones
- Public subnets in both Availability Zones
- Private application subnets in both Availability Zones
- Private database subnets in both Availability Zones
- Production-ready routing architecture

---

# Free Tier Implementation

The architecture diagram represents a production-inspired network design.

To keep deployment costs within the AWS Free Tier, the Terraform implementation will:

- Omit the NAT Gateway.
- Use a simplified routing configuration during deployment.
- Preserve the overall network architecture for learning and portfolio purposes.

---

# Design Summary

The routing architecture provides:

- Secure internet connectivity
- Controlled outbound access
- Private application networking
- Isolated database layer
- Production-inspired routing design
- AWS Free Tier compatible implementation strategy