# Acme Corp --- On-Prem Network Automation

This directory contains the on-premises network automation portion of
the **Acme Corp Hybrid Infrastructure Automation** lab.

The goal of this project is to model a small enterprise network using
structured data, Ansible, and Jinja2 rather than manually maintaining
device configurations. As the project develops, the on-prem environment
will integrate with an AWS environment managed separately through
Infrastructure as Code.

> **Project status:** Early development / Step 1 --- inventory and
> source-of-truth structure.

## Objectives

The on-prem portion of the project is being built to practice
production-oriented network automation patterns:

-   Maintain network data separately from configuration logic.
-   Use Ansible inventory, `group_vars`, and `host_vars` to describe
    infrastructure.
-   Generate repeatable device configurations with Jinja2.
-   Build reusable Ansible roles and playbooks.
-   Validate changes before deployment.
-   Add configuration backup, compliance, and drift detection.
-   Integrate network automation with Git-based review and CI/CD
    workflows.
-   Eventually connect the on-prem environment to the project's AWS
    environment.

## Lab Topology

The initial HQ environment contains:

  Hostname        Role               Management IP
  --------------- ------------------ ---------------
  `edge-rtr01`    Edge Router 01     `10.10.99.1`
  `edge-rtr02`    Edge Router 02     `10.10.99.2`
  `core-sw01`     Core Switch 01     `10.10.99.11`
  `core-sw02`     Core Switch 02     `10.10.99.12`
  `access-sw01`   Access Switch 01   `10.10.99.21`
  `access-sw02`   Access Switch 02   `10.10.99.22`
  `access-sw03`   Access Switch 03   `10.10.99.23`
  `access-sw04`   Access Switch 04   `10.10.99.24`

The management network is:

``` text
VLAN:       99
Network:    10.10.99.0/24
Gateway:    10.10.99.254
Purpose:    Network device management
```

## HQ Addressing Plan

The HQ site uses `10.10.0.0/16` as its overall address space.

  -------------------------------------------------------------------------
                   VLAN Name             Subnet            Purpose
  --------------------- ---------------- ----------------- ----------------
                     10 USERS            `10.10.10.0/24`   Corporate user
                                                           devices

                     20 VOICE            `10.10.20.0/24`   Voice endpoints

                     30 SERVERS          `10.10.30.0/24`   On-prem servers

                     40 IOT              `10.10.40.0/24`   IoT devices

                     50 GUEST            `10.10.50.0/24`   Guest access

                     99 NETWORK-MGMT     `10.10.99.0/24`   Network
                                                           infrastructure
                                                           management
  -------------------------------------------------------------------------

Address space reserved for later phases:

``` text
10.10.0.0/16    HQ / on-prem
10.20.0.0/16    AWS
10.30.0.0/16    Future branch site
```

## Current Repository Structure

``` text
On-Prem-Network/
└── Ansible/
    ├── inventory/
    │   ├── group_vars/
    │   ├── host_vars/
    │   └── hq/
    │       ├── group_vars/
    │       └── host_vars/
    │           ├── access-sw01.yml
    │           ├── access-sw02.yml
    │           ├── access-sw03.yml
    │           ├── access-sw04.yml
    │           ├── core-sw01.yml
    │           ├── core-sw02.yml
    │           ├── edge_rtr01.yml
    │           └── edge_rtr02.yml
    ├── playbooks/
    ├── Roles/
    └── Templates/
```

The repository is intentionally being developed incrementally. Empty
directories will gain functionality as later project phases are
completed.

## Source-of-Truth Approach

Device-specific information belongs in inventory data rather than being
hard-coded into playbooks or templates.

For example, a host variable file may eventually resemble:

``` yaml
---
host:
  name: access-sw01
  ansible_host: 10.10.99.21
```

As the project grows, host and group data will contain information such
as:

``` yaml
device_role:
site:
platform:
management_ip:
vlans:
interfaces:
routing:
ntp_servers:
dns_servers:
```

Ansible and Jinja2 will consume this structured data to create the
desired configuration.

The intended flow is:

``` text
Inventory / YAML
       |
       v
    Jinja2
       |
       v
    Ansible
       |
       v
Network Devices
```

## Planned Ansible Components

### Inventory

`inventory/` stores information describing the network and its devices.

-   `host_vars/` --- variables unique to individual devices.
-   `group_vars/` --- variables shared by groups of devices.
-   `hq/` --- HQ-specific inventory data.

As the project matures, common variables should be placed at the highest
sensible group level instead of duplicated across every host.

### Templates

`Templates/` will contain Jinja2 templates used to generate
configuration from inventory data.

Planned templates include:

``` text
base.j2
vlans.j2
interfaces.j2
routing.j2
ntp.j2
```

### Roles

`Roles/` will contain reusable Ansible roles.

Planned roles include:

``` text
base_config
vlans
interfaces
routing
backup
validation
```

### Playbooks

`playbooks/` will contain operator-facing automation workflows.

Planned playbooks include:

``` text
deploy.yml
backup.yml
validate.yml
rollback.yml
```

## Target Automation Workflow

The long-term workflow for a network change is:

``` text
Change inventory data
        |
        v
Create feature branch
        |
        v
Open merge request
        |
        v
Validate YAML / templates
        |
        v
Render proposed configuration
        |
        v
Review proposed change
        |
        v
Deploy with Ansible
        |
        v
Run post-change validation
        |
        v
Generate results / compliance report
```

A later phase will automate validation through GitLab CI/CD.

## Safety Goals

The project will eventually implement safeguards around network changes
rather than blindly pushing configuration.

Before deployment:

-   Confirm device reachability.
-   Back up the current configuration.
-   Validate inventory data.
-   Validate rendered configuration.
-   Detect obvious addressing or VLAN errors.
-   Review the proposed change.

After deployment:

-   Confirm the device remains reachable.
-   Validate expected configuration/state.
-   Detect unexpected configuration drift.
-   Produce a deployment result.

## Development Workflow

Once the repository is connected to Git, changes should be made through
feature branches.

Example:

``` bash
git checkout -b feature/network-inventory
```

After making a focused change:

``` bash
git add .
git commit -m "Add HQ network inventory"
git push
```

The change should then be reviewed through a merge request before being
merged into the main branch.

## Roadmap

-   [x] Define HQ IP addressing strategy
-   [x] Create initial host variable files
-   [ ] Create Ansible inventory groups
-   [ ] Define shared HQ variables
-   [ ] Define VLAN data model
-   [ ] Define interface data model
-   [ ] Build first Jinja2 template
-   [ ] Render configurations locally
-   [ ] Build first Ansible playbook
-   [ ] Add configuration backup
-   [ ] Add pre-change validation
-   [ ] Add post-change validation
-   [ ] Add Python data validation
-   [ ] Add GitLab repository
-   [ ] Add GitLab CI/CD validation pipeline
-   [ ] Add configuration drift detection
-   [ ] Integrate with AWS/hybrid networking lab

## Project Philosophy

This repository is a learning and portfolio project. The emphasis is not
simply on making automation execute successfully, but on developing
practices that make infrastructure automation **repeatable, reviewable,
testable, and safe**.

The final project should demonstrate the progression from manually
managed network infrastructure toward a Git-based network automation
workflow.

------------------------------------------------------------------------

**Acme Corp is a fictional organization used solely for this lab.**
