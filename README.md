# Power Stack

This repository is the home of my Cloud Stack. 
My personal website and all the cloud based tools that I use in my daily job.

## Overview

All the Tools are installed on a Ubuntu VM as Docker Containers.  
I use Terraform to deploy the VM (and all the other Infrastructure resources) into an Azure Subscription and Docker Compose to run the services.

A Traefik Proxy (configured automatically thanks the [Docker Config Discoovery](https://docs.traefik.io/providers/docker/)) is used asa reverse proxy. 
TODO: continue doc


### Deploy the Infrastructure

Use the action panel:  
[![Actions Panel](https://img.shields.io/badge/deploy-infrastructure-blue)](https://www.actionspanel.app/app/v-braun/power-stack)

Or:  

Go into the infrastructure folder 
``` sh
cd infrastructure
```

Open (or create) the ```local.auto.tfvars``` file and set all variables
``` sh
subscription_id = ""
client_id = ""
client_secret = ""
tenant_id = ""
username = "" # the VM user name
environment = "" # will be used as a tag in azure
name = "" # will be used as a ResourceGroup name or as prefix for net, nsg, etc.
```


Deploy the infrastructure with Terraform 
``` sh
terraform apply
```


### Setup the master node

Set some Variables needed for the next steps
``` sh
VM_IP_ADDRESS=ip_address
VM_USER_NAME=user_name
HOST_NAME=vm_name
```

Create a docker-machine with a generic driver with the new created IP 
``` sh
docker-machine create \
  --driver generic \
  --generic-ip-address=$VM_IP_ADDRESS \
  --generic-ssh-user $VM_USER_NAME \
  --generic-ssh-key ~/.ssh/id_rsa \
  $HOST_NAME

``` 

Switch to the new created machine 
``` sh
eval $(docker-machine env $HOST_NAME)
```

Init docker swarm and create an overlay network  
``` sh
docker swarm init
docker network create -d overlay --attachable main-net
```

Switch back to your local Docker  
``` sh
eval "$(docker-machine env -u)"
```

### Configure DNS
Configure now your DNS to point to the new created VM


### Next steps
Follow the next steps here:
- setup the [proxy](./proxy/README.md#Install)
- setup the [monitoring](./monitoring/README.md#Install)

