# HubSpoke 

## Name
**HubSpoke** architecture, the main idea is to move internal services that currently run directly on VMs and host to containers and deploy automaticaly from gitlab pipelines on diferentes stages development > staging > production using best DevOps practices.

Monitoring services (Metrics, Loggins and Traces)
Health checks
Loadbalance
Pass to production with zero downtime
Enforce security isolating services and VMs
Control changes on infra and services using gitops

  
## Description

Playbook ansible to deployment hub and spoke architecture using IaC (Terraform) and configure a few services using ansible

![Architecture](https:///devops/hubspoke/-/blob/main/docs/architecture-01.jpeg)


## Installation

Clone the repository and execute

```
ansible-playbook main.yaml -i inventory/inventory.yaml
```

## Usage

We need edit inventory/inventory.yaml file with IPs, hostnames, username
Only add or remove host to create the same amount of proxmox resources (vms)
Then you need set group-vars/all.yaml file to configure proxmox credentials (user/pass or API token)
To test you can to use personal credentials

```
pveum role add IaCRole -privs "Datastore.AllocateSpace Datastore.Audit Pool.Allocate Sys.Audit Sys.Console Sys.Modify VM.Allocate VM.Audit VM.Clone VM.Config.CDROM VM.Config.Cloudinit VM.Config.CPU VM.Config.Disk VM.Config.HWType VM.Config.Memory VM.Config.Network VM.Config.Options VM.Migrate VM.Monitor VM.PowerMgmt"
pveum user add iac@pve --password YoUrStr0nGP4sSworD!
pveum aclmod / -user iac@pve -role IaCRole  
```

## Components to install:
### Linux server
- Create worker instances (Minimum recomented 3)
- Create a proxy instance to run Traefik and Traefik-Api in containers
- Create a firewall instance to run VyOS with a few ifaces to act like a Hub
- Create a Bastion instance to manage all instances, launch ansible commands

### ToDo
- [x] Create resources (VMs) on proxmox
- [x] Configure OAM interfaces with IPs
- [x] Create a username passworless on each instance
- [x] Inject ssh public key on each instance
- [x] Terraform variables filled automatically
- [x] Scale in/out vms changing the ansible inventory
- [x] Install docker and dependences in all intances
- [ ] Create user and profiles
- [ ] Create firewall rules
- [ ] Create/validate proxmox bridge with Vlan Aware feature
- [ ] Deploy agent to monitoring OS and Services
- [ ] Create public DNS register
- [ ] Add rules to Reverse Proxy
- [ ] Generate random password

## Pre-requisites
- IPs for OAM interfaces on each instance (Attached by default to vmbr502, internal e1 network)
- 1 proxmox bridge with VLAN aware feature and without interface attached
- 1 prefix /24 to use it to internal comunication (inter worker)
- 3 prefix /30 to links between Firewal and Proxy and Bastion
- 1 public IP attached to firewall, like a unique point to ingress.
- 1 wilcard registry type A/AAA point to public IP (ie *.)


## Custom variables
It require edit variables on [all.yaml](https:///devops/hubspoke/-/blob/main/group_vars/all.yaml) file according to you needs.

The following variables are used to configure networks for the different VMs and basic rules in the firewall, inter vms communication using the internal network and private links. (not used at the moment)

```
oam_gateway: "172.16.17.1"
oam_netmask: "/24"
stage: dev

oam_interface: eth0

proxy_oam_interface: eth0
proxy_oam_ip: "172.16.17.242"
proxy_external_interface: eth1
proxy_external_ip: 10.172.10.2/30
proxy_internal_interface: eth2
proxy_internal_ip: 10.172.20.6/30


firewall_public_interface: eth1
firewall_public_ip: "200.150.20.10/24"
firewall_public_gateway: "200.150.20.1"

firewall_external_interface: eth2
firewall_external_ip: 10.172.10.1/30
firewall_internal_interface: eth3
firewall_internal_ip: 10.172.10.5/30

firewall_bastion_interface: eth4
firewall_bastion_ip: 10.172.10.1/24
firewall_bastion_vlan: 1500

firewall_spoke_interface: eth4
firewall_spoke_ip: 10.172.11.1/24
firewall_spoke_vlan: 1610

```

The following variables are mandatory and are used by terraform to communicate with proxmox and also the user data that will be created for the deployment of services/configurations using ansible

```
tf_pve_api: "https:/:8006/api2/json"
tf_pve_user: ""
tf_pve_password: ""
tf_pve_node: "7"
tf_ssh_username: "{{ ansible_user }}"
tf_ssh_private_key: "/path/to/private/key/sshprivatekey"
tf_ssh_public_key: ""
tf_pve_internal_vmbr: vmbr666
```

