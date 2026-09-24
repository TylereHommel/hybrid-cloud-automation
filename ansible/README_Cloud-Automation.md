# Cloud Automation

## Overview

This section of the Hybrid Cloud Automation project represents the cloud side of the fictional Acme Corp environment.

The cloud environment is simulated locally so the project can be developed, tested, and demonstrated without an AWS account or paid cloud infrastructure.

Damien's responsibilities include:

- Terraform infrastructure automation
- Simulated cloud infrastructure
- Ansible cloud configuration
- Verification and idempotency testing

## Cloud Architecture

```text
Simulated Cloud Environment
            |
        Terraform
            |
    +-------+-------+
    |               |
 Web Server      Database Server
    |               |
 web-server.txt database-server.txt
    |               |
    +-------+-------+
            |
          Ansible
            |
      Configuration
            |
    +-------+-------+
    |               |
   web01           db01
    |               |
/tmp/acme-web   /tmp/acme-db