# Terraform

## What is Terraform

Terraform is an open source “Infrastructure as Code” tool, created by HashiCorp.

A declarative coding tool, Terraform enables developers to use a high-level configuration language called HCL (HashiCorp Configuration Language) to describe the desired “end-state” cloud or on-premises infrastructure for running an application. It then generates a plan for reaching that end-state and executes the plan to provision the infrastructure.

## Why Infrastructure as Code (IaC)?
IaC allows developers to codify infrastructure in a way that makes provisioning automated, faster, and repeatable. It’s a key component of Agile and DevOps practices such as version control, continuous integration, and continuous deployment.

Infrastructure as code can help with the following:

- **Improve speed**: Automation is faster than manually navigating an interface when you need to deploy and/or connect resources.

- **Improve reliability**: If your infrastructure is large, it becomes easy to misconfigure a resource or provision services in the wrong order. With IaC, the resources are always provisioned and configured exactly as declared.

- **Prevent configuration drift**: Configuration drift occurs when the configuration that provisioned your environment no longer matches the actual environment. (See ‘Immutable infrastructure’ below.)

- **Support experimentation, testing, and optimization**: Because Infrastructure as Code makes provisioning new infrastructure so much faster and easier, you can make and test experimental changes without investing lots of time and resources; and if you like the results, you can quickly scale up the new infrastructure for production.


## Why Terraform?
There are a few key reasons developers choose to use Terraform over other Infrastructure as Code tools:

- **Open source**: Terraform is backed by large communities of contributors who build plugins to the platform. Regardless of which cloud provider you use, it’s easy to find plugins, extensions, and professional support. This also means Terraform evolves quickly, with new benefits and improvements added consistently.
- **Platform agnostic**: Meaning you can use it with any cloud services provider. Most other IaC tools are designed to work with single cloud provider.
- **Immutable infrastructure**: Most Infrastructure as Code tools create mutable infrastructure, meaning the infrastructure can change to accommodate changes such as a middleware upgrade or new storage server. The danger with mutable infrastructure is configuration drift—as the changes pile up, the actual provisioning of different servers or other infrastructure elements ‘drifts’ further from the original configuration, making bugs or performance issues difficult to diagnose and correct. Terraform provisions immutable infrastructure, which means that with each change to the environment, the current configuration is replaced with a new one that accounts for the change, and the infrastructure is reprovisioned. Even better, previous configurations can be retained as versions to enable rollbacks if necessary or desired.


## Popular IaC Tools:

- **Terraform** An open-source declarative tool that offers pre-written modules to build and manage an infrastructure.
- **Chef**: A configuration management tool that uses cookbooks and recipes to deploy the desired environment. Best used for Deploying and configuring applications using a pull-based approach.
- **Puppet**: Popular tool for configuration management that follows a Client-Server Model. Puppet needs agents to be deployed on the target machines before the puppet can start managing them.
- **Ansible**: Ansible is used for building infrastructure as well as deploying and configuring applications on top of them. Best used for Ad hoc analysis.
- **Packer**: Unique tool that generates VM images (not running VMs) based on steps you provide. Best used for Baking compute images.
- **Vagrant**: Builds VMs using a workflow. Best used for Creating pre-configured developer VMs within VirtualBox.

## Terraform vs. Ansible

- Terraform and Ansible are both Infrastructure as Code tools, but there are a couple significant differences between the two:

- While Terraform is purely a declarative tool , Ansible combines both declarative and procedural configuration. 
- In procedural configuration, you specify the steps, or the precise manner, in which you want to provision infrastructure to the desired   state. Procedural configuration is more work but it provides more control.
- Terraform is open source; Ansible is developed and sold by Red Hat.
- Terraform is not fit to do configuration management on the software on your machines. 
- Ansible/Chef/Puppet/Salt are better alternatives to do that. 
- Terraform can work together with these tools to provide you CI on your machines. 
- Terraform provides Configuration Management on an infrastructure level, not on the level of software of your machines.

## Terraform Commands


![vs. Ansible](images/terraform-life-cycle.JPG)

### terraform init

        $ terraform init

        Initializing the backend...

        Initializing provider plugins...
        - Finding latest version of hashicorp/aws...
        - Installing hashicorp/aws v3.28.0...
        - Installed hashicorp/aws v3.28.0 (signed by HashiCorp)

        Terraform has created a lock file .terraform.lock.hcl to record the provider  
        selections it made above. Include this file in your version control repository
        so that Terraform can guarantee to make the same selections by default when
        you run "terraform init" in the future.

        Terraform has been successfully initialized!

        You may now begin working with Terraform. Try running "terraform plan" to see
        any changes that are required for your infrastructure. All Terraform commands
        should now work.

        If you ever set or change modules or backend configuration for Terraform,
        rerun this command to reinitialize your working directory. If you forget, other
        commands will detect it and remind you to do so if necessary.



### terraform plan

        $ terraform plan

        An execution plan has been generated and is shown below.
        Resource actions are indicated with the following symbols:
        + create

        Terraform will perform the following actions:

        # aws_instance.example will be created
        + resource "aws_instance" "example" {
            + ami                          = "ami-047a51fa27710816e"
            + arn                          = (known after apply)
            + associate_public_ip_address  = (known after apply)
            + availability_zone            = (known after apply)
            + cpu_core_count               = (known after apply)
            + cpu_threads_per_core         = (known after apply)
            + get_password_data            = false
            + host_id                      = (known after apply)
            + id                           = (known after apply)
            + instance_state               = (known after apply)
            + instance_type                = "t2.micro"
            + ipv6_address_count           = (known after apply)
            + ipv6_addresses               = (known after apply)
            + key_name                     = (known after apply)
            + outpost_arn                  = (known after apply)
            + password_data                = (known after apply)
            + placement_group              = (known after apply)
            + primary_network_interface_id = (known after apply)
            + private_dns                  = (known after apply)
            + private_ip                   = (known after apply)
            + public_dns                   = (known after apply)
            + public_ip                    = (known after apply)
            + secondary_private_ips        = (known after apply)
            + security_groups              = (known after apply)
            + source_dest_check            = true
            + subnet_id                    = (known after apply)
            + tenancy                      = (known after apply)
            + vpc_security_group_ids       = (known after apply)

            + ebs_block_device {
                + delete_on_termination = (known after apply)
                + device_name           = (known after apply)
                + encrypted             = (known after apply)
                + iops                  = (known after apply)
                + kms_key_id            = (known after apply)
                + snapshot_id           = (known after apply)
                + tags                  = (known after apply)
                + throughput            = (known after apply)
                + volume_id             = (known after apply)
                + volume_size           = (known after apply)
                + volume_type           = (known after apply)
                }

            + enclave_options {
                + enabled = (known after apply)
                }

            + ephemeral_block_device {
                + device_name  = (known after apply)
                + no_device    = (known after apply)
                + virtual_name = (known after apply)
                }

            + metadata_options {
                + http_endpoint               = (known after apply)
                + http_put_response_hop_limit = (known after apply)
                + http_tokens                 = (known after apply)
                }

            + network_interface {
                + delete_on_termination = (known after apply)
                + device_index          = (known after apply)
                + network_interface_id  = (known after apply)
                }

            + root_block_device {
                + delete_on_termination = (known after apply)
                + device_name           = (known after apply)
                + encrypted             = (known after apply)
                + iops                  = (known after apply)
                + kms_key_id            = (known after apply)
                + tags                  = (known after apply)
                + throughput            = (known after apply)
                + volume_id             = (known after apply)
                + volume_size           = (known after apply)
                + volume_type           = (known after apply)
                }
            }

        Plan: 1 to add, 0 to change, 0 to destroy.

        ------------------------------------------------------------------------

        Note: You didn't specify an "-out" parameter to save this plan, so Terraform
        can't guarantee that exactly these actions will be performed if
        "terraform apply" is subsequently run.



### terraform apply

        $ terraform apply

        An execution plan has been generated and is shown below.
        Resource actions are indicated with the following symbols:
        + create

        Terraform will perform the following actions:

        # aws_instance.example will be created
        + resource "aws_instance" "example" {
            + ami                          = "ami-047a51fa27710816e"
            + arn                          = (known after apply)
            + associate_public_ip_address  = (known after apply)
            + availability_zone            = (known after apply)
            + cpu_core_count               = (known after apply)
            + cpu_threads_per_core         = (known after apply)
            + get_password_data            = false
            + host_id                      = (known after apply)
            + id                           = (known after apply)
            + instance_state               = (known after apply)
            + instance_type                = "t2.micro"
            + ipv6_address_count           = (known after apply)
            + ipv6_addresses               = (known after apply)
            + key_name                     = (known after apply)
            + outpost_arn                  = (known after apply)
            + password_data                = (known after apply)
            + placement_group              = (known after apply)
            + primary_network_interface_id = (known after apply)
            + private_dns                  = (known after apply)
            + private_ip                   = (known after apply)
            + public_dns                   = (known after apply)
            + public_ip                    = (known after apply)
            + secondary_private_ips        = (known after apply)
            + security_groups              = (known after apply)
            + source_dest_check            = true
            + subnet_id                    = (known after apply)
            + tenancy                      = (known after apply)
            + vpc_security_group_ids       = (known after apply)

            + ebs_block_device {
                + delete_on_termination = (known after apply)
                + device_name           = (known after apply)
                + encrypted             = (known after apply)
                + iops                  = (known after apply)
                + kms_key_id            = (known after apply)
                + snapshot_id           = (known after apply)
                + tags                  = (known after apply)
                + throughput            = (known after apply)
                + volume_id             = (known after apply)
                + volume_size           = (known after apply)
                + volume_type           = (known after apply)
                }

            + enclave_options {
                + enabled = (known after apply)
                }

            + ephemeral_block_device {
                + device_name  = (known after apply)
                + no_device    = (known after apply)
                + virtual_name = (known after apply)
                }

            + metadata_options {
                + http_endpoint               = (known after apply)
                + http_put_response_hop_limit = (known after apply)
                + http_tokens                 = (known after apply)
                }

            + network_interface {
                + delete_on_termination = (known after apply)
                + device_index          = (known after apply)
                + network_interface_id  = (known after apply)
                }

            + root_block_device {
                + delete_on_termination = (known after apply)
                + device_name           = (known after apply)
                + encrypted             = (known after apply)
                + iops                  = (known after apply)
                + kms_key_id            = (known after apply)
                + tags                  = (known after apply)
                + throughput            = (known after apply)
                + volume_id             = (known after apply)
                + volume_size           = (known after apply)
                + volume_type           = (known after apply)
                }
            }

        Plan: 1 to add, 0 to change, 0 to destroy.

        Do you want to perform these actions?
        Terraform will perform the actions described above.
        Only 'yes' will be accepted to approve.

        Enter a value: yes

        aws_instance.example: Creating...
        aws_instance.example: Still creating... [10s elapsed]
        aws_instance.example: Still creating... [20s elapsed]
        aws_instance.example: Creation complete after 26s [id=i-0f3d60c7208aefebb]

        Apply complete! Resources: 1 added, 0 changed, 0 destroyed.


![instace](/images/instance-1.JPG)

### terraform destroy

        $ terraform destroy

        An execution plan has been generated and is shown below.
        Resource actions are indicated with the following symbols:
        - destroy

        Terraform will perform the following actions:

        # aws_instance.example will be destroyed
        - resource "aws_instance" "example" {
            - ami                          = "ami-047a51fa27710816e" -> null
            - arn                          = "arn:aws:ec2:us-east-1:119956859268:instance/i-0f3d60c7208aefebb" -> null
            - associate_public_ip_address  = true -> null
            - availability_zone            = "us-east-1e" -> null
            - cpu_core_count               = 1 -> null
            - cpu_threads_per_core         = 1 -> null    
            - disable_api_termination      = false -> null
            - ebs_optimized                = false -> null
            - get_password_data            = false -> null
            - hibernation                  = false -> null
            - id                           = "i-0f3d60c7208aefebb" -> null
            - instance_state               = "running" -> null
            - instance_type                = "t2.micro" -> null
            - ipv6_address_count           = 0 -> null
            - ipv6_addresses               = [] -> null
            - monitoring                   = false -> null
            - primary_network_interface_id = "eni-0dfb94697b5e828f6" -> null
            - private_dns                  = "ip-172-31-49-70.ec2.internal" -> null
            - private_ip                   = "172.31.49.70" -> null
            - public_dns                   = "ec2-3-90-83-162.compute-1.amazonaws.com" -> null
            - public_ip                    = "3.90.83.162" -> null
            - secondary_private_ips        = [] -> null
            - security_groups              = [
                - "default",
                ] -> null
            - source_dest_check            = true -> null
            - subnet_id                    = "subnet-8952f4b8" -> null
            - tenancy                      = "default" -> null
            - vpc_security_group_ids       = [
                - "sg-fafcc2f0",
                ] -> null

            - credit_specification {
                - cpu_credits = "standard" -> null
                }

            - enclave_options {
                - enabled = false -> null
                }

            - metadata_options {
                - http_endpoint               = "enabled" -> null
                - http_put_response_hop_limit = 1 -> null
                - http_tokens                 = "optional" -> null
                }

            - root_block_device {
                - delete_on_termination = true -> null
                - device_name           = "/dev/xvda" -> null
                - encrypted             = false -> null
                - iops                  = 100 -> null
                - tags                  = {} -> null
                - throughput            = 0 -> null
                - volume_id             = "vol-052462918a3d5fce8" -> null
                - volume_size           = 8 -> null
                - volume_type           = "gp2" -> null
                }
            }

        Plan: 0 to add, 0 to change, 1 to destroy.

        Do you really want to destroy all resources?
        Terraform will destroy all your managed infrastructure, as shown above.
        There is no undo. Only 'yes' will be accepted to confirm.

        Enter a value: yes

        aws_instance.example: Destroying... [id=i-0f3d60c7208aefebb]
        aws_instance.example: Still destroying... [id=i-0f3d60c7208aefebb, 10s elapsed]
        aws_instance.example: Still destroying... [id=i-0f3d60c7208aefebb, 20s elapsed]
        aws_instance.example: Still destroying... [id=i-0f3d60c7208aefebb, 30s elapsed]
        aws_instance.example: Destruction complete after 32s

        Destroy complete! Resources: 1 destroyed.


![instace](/images/instance-1-terminated.JPG)