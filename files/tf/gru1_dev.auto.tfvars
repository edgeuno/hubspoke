
pve_api = "https://:8006/api2/json"
pve_user = "root@pam"
pve_password = ""
pve_node = "pve006-gru1"
ssh_username = "e1deployer"
ssh_private_key = "/home/jlopez/dev/iac/ansible/hubspoke/files/keys/e1deployer"
ssh_public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCoP95Ds+pwL+NWt750Ax1vh+cTLQKiF5i+G4z4F74WR2tGKAuE2s6d00z24GzS7/c9LV/6Sm5ujaI3+9FeiwkBbJz7hP//M2xcGUzFKZZzcCd0JwAK5ih6OMVVbiLH3TTqnHfqtQcoshUSZjHNXBq0Jj+jhStZ139bYsnzlW1RRe1Z851KIsoVd5J0bpIr2o4zpm9HCgB8S/j6aMw/v1Zump01xiPaDTTjKgHGRpFdoD/xLZF9Cjjv3JgBEIodCfBxuEdzo9FO8hrcgRm9jVEXIL/X7+3R36z09azK2IUfi6t4K4oGjNl8JFEa3rDYfb5O4f+OqD8cJMVSaBptcLSm/MCar/n3/xI4BFDx1tUluablTSzD07VzzVKbdvZRIsSY2PKqYE4ePqZDZa0jslJpyd94zyTvzqUH7vlBNxLSoam82Hh/E+LgQoRGsEJBEAkmjkOUE5yJE9zyuZ51LQpk/9/xc0z2HPQ8sLDiisSGrv0hg5p11/dRLxzQ2SQYNa8= e1deployer@localhost"
pve_internal_vmbr = "vmbr900"
pve_external_vmbr = "vmbr602"
pve_oam_vmbr = "vmbr502"

node_config = [
  {
    vmid = 4004
    name = "e1-gru1-dev-control-11"
    ip_address = "172.23.52.90/24"
    ip_gateway = "172.23.52.1"
    image = "Ubuntu20"
    cores = 1
    sockets = 1
    memory = 2048
    disk_size = "5G"
  },  
  {
    vmid = 4005
    name = "e1-gru1-dev-control-12"
    ip_address = "172.23.52.91/24"
    ip_gateway = "172.23.52.1"
    image = "Ubuntu20"
    cores = 1
    sockets = 1
    memory = 2048
    disk_size = "5G"
  },  
  {
    vmid = 4006
    name = "e1-gru1-dev-control-13"
    ip_address = "172.23.52.92/24"
    ip_gateway = "172.23.52.1"
    image = "Ubuntu20"
    cores = 1
    sockets = 1
    memory = 2048
    disk_size = "5G"
  },  
]

worker_config = [
  {
    name = "e1-gru1-dev-worker-11"
    ip_address = "172.23.52.93/24"
    ip_gateway = "172.23.52.1"
    vmid = 4007
  },  
  {
    name = "e1-gru1-dev-worker-12"
    ip_address = "172.23.52.94/24"
    ip_gateway = "172.23.52.1"
    vmid = 4008
  },  
  {
    name = "e1-gru1-dev-worker-13"
    ip_address = "172.23.52.95/24"
    ip_gateway = "172.23.52.1"
    vmid = 4009
  },  
]

firewall_config = [
  {
    name = "e1-gru1-dev-firewall-11"
    ip_address = "172.23.52.84/24"
    ip_gateway = "172.23.52.1"
    vmid = 4000
  },  
]

proxy_config = [
  {
    name = "e1-gru1-dev-proxy-11"
    ip_address = "172.23.52.87/24"
    ip_gateway = "172.23.52.1"
    vmid = 4002
  },  
  {
    name = "e1-gru1-dev-proxy-12"
    ip_address = "172.23.52.88/24"
    ip_gateway = "172.23.52.1"
    vmid = 4003
  },  
]


