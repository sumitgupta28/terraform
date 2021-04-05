# Terraform on GCP (Google Cloud Platform)

## [Setup GCP Project and Service Account](../01-gcp-setup/README.md) 

## Terraform Configuration 

Here is the configuration for setting up CGP Provider

```sh

    terraform {
    required_providers {
        google = {
        source  = "hashicorp/google"
        version = "3.5.0"
        }
    }
    }

    provider "google" {
    credentials = file(var.GCP_CRED_FILE_NAME)
    project     = var.GCP_PROJECT_ID
    region      = var.GCP_REGION
    zone        = var.GCP_ZONE
    }

```

and Variable values are 

```sh
    GCP_PROJECT_ID     = "<<PROJECT_ID>>"
    GCP_REGION         = "us-central1"
    GCP_ZONE           = "us-central1-a"
    GCP_CRED_FILE_NAME = "<<Credential_json_file>>.json"
```

![GCP-Terraform-setup.JPG](../images/GCP-Terraform-setup.JPG)


With this now we are ready to create GCP resources with Terrafrom. 


# Create VPC

```sh

    ## Create a VPC network
    resource "google_compute_network" "terraform-network-vpc" {
    name                    = "terraform-network"
    description             = "a Test vpc Network"
    auto_create_subnetworks = false
    routing_mode            = "REGIONAL"
    }
```

# Create Public and Prviate Subnet
```sh
    ## Create a Public Subnet
    resource "google_compute_subnetwork" "us-central1-public-subnet" {
    name          = "us-central1-public-subnet"
    description   = "us-central1-public-subnet"
    ip_cidr_range = "10.0.0.0/24"
    region        = var.GCP_REGION
    network       = google_compute_network.terraform-network-vpc.id
    }

    ## Create a private Subnet
    resource "google_compute_subnetwork" "us-central1-private-subnet" {
    name          = "us-central1-private-subnet"
    description   = "us-central1-private-subnet"
    ip_cidr_range = "10.0.1.0/24"
    region        = var.GCP_REGION
    network       = google_compute_network.terraform-network-vpc.id
    }
``` 

## Create firewall Rules

```sh

    ## Create a firewall rule - allow-icmp
    resource "google_compute_firewall" "allow-icmp-custom" {
    name    = "allow-icmp-custom"
    network = google_compute_network.terraform-network-vpc.name
    allow {
        protocol = "icmp"
        
    }
    source_ranges = [ "0.0.0.0/0" ]

    priority = 65534
    source_tags = ["web"]
    }


    ## Create a firewall rule - allow-ssh
    resource "google_compute_firewall" "allow-ssh" {
    name    = "allow-icmp"
    network = google_compute_network.terraform-network-vpc.name
    
    allow {
        protocol = "tcp"
        ports    = ["22"]
    }
    source_ranges = [ "0.0.0.0/0" ]

    priority = 65534
    source_tags = ["web"]
    }

```

### VM instance for Public Subnet
```sh
    ## Create a VM instance in public subnet
    resource "google_compute_instance" "app-instance-public" {
    name         = "test-app-server"
    machine_type = "f1-micro"
    zone         = var.GCP_ZONE

    boot_disk {
        initialize_params {
        image = "debian-cloud/debian-9"
        }
    }

    network_interface {
        access_config {}
        network    = google_compute_network.terraform-network-vpc.id
        subnetwork = google_compute_subnetwork.us-central1-public-subnet.name
    }
    }

    output "test-app-server-public-nat_ip" {
    value = google_compute_instance.app-instance-public.network_interface[0].access_config[0].nat_ip
    }
    output "test-app-server-private-ip" {
    value = google_compute_instance.app-instance-public.network_interface[0].network_ip
    }
```


### VM instance for Private Subnet
```sh
    ## Create a VM instance in private subnet
    resource "google_compute_instance" "app-instance-private" {
    name         = "test-backend-server"
    machine_type = "f1-micro"
    zone         = var.GCP_ZONE

    boot_disk {
        initialize_params {
        image = "debian-cloud/debian-9"
        }
    }
    network_interface {
        network    = google_compute_network.terraform-network-vpc.id
        subnetwork = google_compute_subnetwork.us-central1-private-subnet.name
    }
    }

    output "test-backend-app-instance-private-ip" {
    value = google_compute_instance.app-instance-private.network_interface[0].network_ip
    }

```

### & finally a Router and NAT Gateway for Private subnet

```sh

    ## Create Router 
    resource "google_compute_router" "my-router" {
    name    = "my-router"
    description = "my-router"
    network = google_compute_network.terraform-network-vpc.name
    region                             = var.GCP_REGION
    }

    ## Create NAT Gateway
    resource "google_compute_router_nat" "nat" {
    name                               = "my-router-nat"
    router                             = google_compute_router.my-router.name
    region                             = var.GCP_REGION
    nat_ip_allocate_option             = "AUTO_ONLY"
    source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"
    }

```

### lets verify 

- terraform-network is created with SUBNET_MODE as CUSTOM.

```sh

    $ gcloud compute networks list
    NAME               SUBNET_MODE  BGP_ROUTING_MODE  IPV4_RANGE  GATEWAY_IPV4
    default            AUTO         REGIONAL
    terraform-network  CUSTOM       REGIONAL
```


- subnet "us-central1-subnetwork" is created in terraform-network in us-central1 region.

```sh
    $ gcloud compute networks  subnets list --filter="network:( terraform-network )"
    NAME                        REGION       NETWORK            RANGE
    us-central1-private-subnet  us-central1  terraform-network  10.0.1.0/24
```


- firewall rules , test-firewall is created under terraform-network

```sh

    $ gcloud compute firewall-rules list
    NAME                    NETWORK            DIRECTION  PRIORITY  ALLOW                         DENY  DISABLED
    allow-icmp              terraform-network  INGRESS    65534     tcp:22                              False
    allow-icmp-custom       terraform-network  INGRESS    65534     icmp                                False
    default-allow-http      default            INGRESS    1000      tcp:80                              False
    default-allow-icmp      default            INGRESS    65534     icmp                                False
    default-allow-internal  default            INGRESS    65534     tcp:0-65535,udp:0-65535,icmp        False
    default-allow-rdp       default            INGRESS    65534     tcp:3389                            False
    default-allow-ssh       default            INGRESS    65534     tcp:22                              False

```
- routes created..

```sh

    $ gcloud compute routes list --filter "network:( terraform-network )"
    NAME                            NETWORK            DEST_RANGE   NEXT_HOP                  PRIORITY
    default-route-86087a5ad3dde069  terraform-network  10.0.1.0/24  terraform-network         0
    default-route-dde1c26d2f0dc311  terraform-network  0.0.0.0/0    default-internet-gateway  1000

```

- An instance is created in the newly created vpc.

```sh 
    gcloud compute instances list
    NAME                       ZONE           MACHINE_TYPE  PREEMPTIBLE  INTERNAL_IP  EXTERNAL_IP  STATUS
    terraform-maintained-4h9f  us-central1-a  f1-micro                   10.0.1.2                  RUNNING
```

- ssh into instance and validate the ngnix is up and running 

```sh
    $ gcloud compute ssh terraform-maintained-4h9f --zone=us-central1-a
    External IP address was not found; defaulting to using IAP tunneling.
    Linux terraform-maintained-4h9f 4.19.0-14-cloud-amd64 #1 SMP Debian 4.19.171-2 (2021-01-30) x86_64
    The programs included with the Debian GNU/Linux system are free software;
    the exact distribution terms for each program are described in the
    individual files in /usr/share/doc/*/copyright.
    Debian GNU/Linux comes with ABSOLUTELY NO WARRANTY, to the extent
    permitted by applicable law.
    Last login: Mon Apr  5 07:29:08 2021 from 35.235.241.17
    sumitgupta28@terraform-maintained-4h9f:~$ curl localhost
    <!DOCTYPE html>
    <html>
    <head>
    <title>Welcome to nginx!</title>
    <style>
        body {
            width: 35em;
            margin: 0 auto;
            font-family: Tahoma, Verdana, Arial, sans-serif;
        }
    </style>
    </head>
    <body>
    <h1>Welcome to nginx!</h1>
    <p>If you see this page, the nginx web server is successfully installed and
    working. Further configuration is required.</p>
    <p>For online documentation and support please refer to
    <a href="http://nginx.org/">nginx.org</a>.<br/>
    Commercial support is available at
    <a href="http://nginx.com/">nginx.com</a>.</p>
    <p><em>Thank you for using nginx.</em></p>
    </body>
    </html>    

```
