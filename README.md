# Hybrid Cloud Automation
## Overview

This project demonstrates infrastructure automation across a fictional Acme Corp hybrid environment.

The project is divided into two areas:

- On-premises network automation
- Simulated cloud infrastructure automation

## Architecture

```text
ACME CORP
│
├── ON-PREMISES
│   └── Tyler
│       ├── Cisco Networking
│       ├── Ansible
│       ├── Jinja2
│       └── Network Automation
│
└── SIMULATED CLOUD
    └── Damien
        ├── Terraform
        ├── Local Provider
        └── Ansible

 ## Automation Workflow

```text
Terraform
    │
    ▼
Simulated Cloud Infrastructure
    │
    ▼
Ansible Inventory
    │
    ▼
Ansible Configuration
    │
    ├── Web Server
    │
    └── Database Server
    │
    ▼
Verification
    │
    ▼
Idempotency Testing       

## Cloud Automation

The cloud portion of the project is intentionally simulated locally.

No AWS account, AWS credentials, AWS CLI, or paid cloud infrastructure are required.

### Terraform

Terraform represents the simulated cloud infrastructure using the Local provider.

Terraform manages:

- Acme test resource
- Simulated web server
- Simulated database server

### Ansible

Ansible configures the simulated cloud hosts:

- `web01` — simulated web server
- `db01` — simulated database server

Both hosts use local connections.

### Verification

The configuration can be verified by checking:

- Terraform state
- Terraform outputs
- Ansible connectivity
- Web server configuration
- Database configuration
- Ansible idempotency

## Project Structure

```text
hybrid-cloud-automation/
│
├── README.md
│
├── ansible/
│   ├── README_On-Prem-Network.md
│   ├── README_Cloud-Automation.md
│   │
│   ├── inventory/
│   │   ├── awscloud/
│   │   │   └── host.yml
│   │   └── on-prem-network/
│   │       └── hq/
│   │           └── hosts.yml
│   │
│   ├── playbooks/
│   │   ├── site.yml
│   │   ├── db.yml
│   │   └── render-vlans.yml
│   │
│   └── templates/
│       └── vlans.j2
│
├── terraform/
│   ├── main.tf
│   ├── variables.tf
│   └── outputs.tf
│
├── requirements.txt
└── requirements.yml

## Setup

Clone the repository and enter the project directory:

```bash
git clone git@github.com:TylereHommel/hybrid-cloud-automation.git
cd hybrid-cloud-automation