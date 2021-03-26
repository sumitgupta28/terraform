## Terraform Commands

| Commands                            | Commands                            |
| -------------                       | -------------                       |
| [fmt](#terraform-fmt)               | [providers](#terraform-providers)   |
| [init](#terraform-init)             | [validate](#terraform-validate)     |
| [plan](#terraform-plan)             | [apply](#terraform-apply)           |
| [destroy](#terraform-destroy)       | [graph](#terraform-graph)           |
| [output](#terraform-output)         | [taint and untaint](#terraform-taint)|
| [workspace](#terraform-workspace)   | [state](#terraform-state)          |
| [refresh](#terraform-refresh)       | [force-unlock](#terraform-force-unlock)          |
| [get](#terraform-get)               | [show](#terraform-show)          |

### terraform fmt

        Reformat your configuration in the standard style

### terraform providers

Providers are a logical abstraction of an upstream API. They are responsible for understanding API interactions and exposing resources. 
for example for using the terraform with AWS you will need aws provider. All the providers can be found [here](https://registry.terraform.io/browse/providers).

[init](#terraform-init) add the providers to the project and will be available at  **.terraform\providers\registry.terraform.io\hashicorp**

        $ terraform providers

        Providers required by configuration:
        .       
        ├── provider[registry.terraform.io/hashicorp/aws]
        └── provider[registry.terraform.io/hashicorp/template]        

### terraform init

The terraform init command is used to initialize a working directory containing Terraform configuration files. This is the first command that should be run after writing a new Terraform configuration or cloning an existing one from version control. It is safe to run this command multiple times.

This command performs several different initialization steps in order to prepare the current working directory for use with Terraform.

#### Copy a Source Module

By default, terraform init assumes that the working directory already contains a configuration and will attempt to initialize that configuration.

init can be run against an empty directory with the -from-module=MODULE-SOURCE option, in which case the given module will be copied into the target directory before any other initialization steps are run.


#### Backend Initialization
init, the root configuration directory is consulted for backend configuration and the chosen backend is initialized using the given configuration settings.


#### Child Module Installation
init, the configuration is searched for module blocks, and the source code for referenced modules is retrieved from the locations given in their source arguments.

#### Plugin Installation
Most Terraform providers are published separately from Terraform as plugins. During init, Terraform searches the configuration for both direct and indirect references to providers and attempts to install the plugins for those providers.

**Example**

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

### terraform validate
The terraform validate command validates the configuration files in a directory, referring only to the configuration and not accessing any remote services such as remote state, provider APIs, etc.

Validate runs checks that verify whether a configuration is syntactically valid and internally consistent, regardless of any provided variables or existing state. It is thus primarily useful for general verification of reusable modules, including correctness of attribute names and value types.

**Example**

        $ terraform validate
        Success! The configuration is valid.

### terraform plan

The terraform plan command is used to create an execution plan. Terraform performs a refresh, unless explicitly disabled, and then determines what actions are necessary to achieve the desired state specified in the configuration files.

**Example**

**terraform plan** or **terraform plan -out aws-ec2.plan** , this plan file can be re-used while doing apply. 



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

The terraform apply command is used to apply the changes required to reach the desired state of the configuration, or the pre-determined set of actions generated by a terraform plan execution plan.


**terraform apply** or **terraform apply -auto-approve aws-ec2.plan ** 

- **-auto-approve** option won;t ask you to confirm again. 

During the **terraform apply**
- Refresh the data source
- **Created resources** that exist in .tf files but not in state file. 
- **Delete resources** that exist in state files but not in .tf files. 
- **Update resources** that have different argument in the .tf files then on the cloud provider. 
    - **Destroy and re-create** resource that have argument changed that require re-creation [ like a chnage to user_data in ec2 instance always need re-creation]
    - **In Place update** are possible if provider api support it like security group update.


**Example**

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

### terraform output
Print the output shown post Apply.


**Example**

        $ terraform output
        application-server-arn = "arn:aws:ec2:us-east-1:119956859268:instance/i-0f946ffa9d28addd8"
        application-server-private_ip = "10.0.1.54"
        application-server-public_ip = "3.239.234.128"
        aws_eip-nat-public_ip = "52.55.141.238"
        aws_nat_gateway-nat-gw-public_ip = "52.55.141.238"
        rds = "mariadb.cgi4z9yx8mvq.us-east-1.rds.amazonaws.com:3306"

![instace](/images/instance-1.JPG)



### terraform destroy

The terraform destroy command is used to destroy the Terraform-managed infrastructure.

**Example**

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


Destroy an specific resource. 

"/git-hub-demo" creates 2 repository if you would to delete 1 of them then use like below. 


        $ terraform destroy -target=github_repository.terraform-repo-sumitgupta28-test -auto-approve
        github_repository.terraform-repo-sumitgupta28-test: Destroying... [id=terraform-repo-sumitgupta28-test]
        github_repository.terraform-repo-sumitgupta28-test: Destruction complete after 0s

        Warning: Resource targeting is in effect

        You are creating a plan with the -target option, which means that the result
        of this plan may not represent all of the changes requested by the current
        configuration.

        The -target option is not for routine use, and is provided only for
        exceptional situations such as recovering from errors or mistakes, or when
        Terraform specifically suggests to use it as part of an error message.

        Warning: Applied changes may be incomplete

        The plan was created with the -target option in effect, so some changes
        requested in the configuration may have been ignored and the output values may
        not be fully updated. Run the following command to verify that no other
        changes are pending:
            terraform plan

        Note that the -target option is not suitable for routine use, and is provided
        only for exceptional situations such as recovering from errors or mistakes, or
        when Terraform specifically suggests to use it as part of an error message.

        Destroy complete! Resources: 1 destroyed.



### terraform graph
The terraform graph command is used to generate a visual representation of either a configuration or execution plan. The output is in the DOT format, which can be used by GraphViz to generate charts.

**Example**

        $ terraform graph
        digraph {
                compound = "true"
                newrank = "true"
                subgraph "root" {
                        "[root] aws_eip.nat (expand)" [label = "aws_eip.nat", shape = "box"]
                        "[root] aws_instance.public-ec2 (expand)" [label = "aws_instance.public-ec2", shape = "box"]
                        "[root] aws_internet_gateway.main-gw (expand)" [label = "aws_internet_gateway.main-gw", shape = "box"]
                        "[root] aws_key_pair.mykeypair (expand)" [label = "aws_key_pair.mykeypair", shape = "box"]
                        "[root] aws_nat_gateway.nat-gw (expand)" [label = "aws_nat_gateway.nat-gw", shape = "box"]
                        "[root] aws_route_table.main-private (expand)" [label = "aws_route_table.main-private", shape = "box"]
                        "[root] aws_route_table.main-public (expand)" [label = "aws_route_table.main-public", shape = "box"]
                        "[root] aws_route_table_association.main-private-1-a (expand)" [label = "aws_route_table_association.main-private-1-a", shape = "box"]
                        "[root] aws_route_table_association.main-public-1-a (expand)" [label = "aws_route_table_association.main-public-1-a", shape = "box"]
                        "[root] aws_security_group.allow-http (expand)" [label = "aws_security_group.allow-http", shape = "box"]
                        "[root] aws_security_group.allow-ssh (expand)" [label = "aws_security_group.allow-ssh", shape = "box"]
                        "[root] aws_subnet.main-private-1 (expand)" [label = "aws_subnet.main-private-1", shape = "box"]
                        "[root] aws_subnet.main-public-1 (expand)" [label = "aws_subnet.main-public-1", shape = "box"]
                        "[root] aws_vpc.main (expand)" [label = "aws_vpc.main", shape = "box"]
                        "[root] data.template_cloudinit_config.cloudinit-startup-script (expand)" [label = "data.template_cloudinit_config.cloudinit-startup-script", shape = "box"]
                        "[root] data.template_file.shell-script (expand)" [label = "data.template_file.shell-script", shape = "box"]
                        "[root] output.aws_eip-nat-public_ip" [label = "output.aws_eip-nat-public_ip", shape = "note"]
                        "[root] output.aws_nat_gateway-nat-gw-public_ip" [label = "output.aws_nat_gateway-nat-gw-public_ip", shape = "note"]
                        "[root] output.public-ec2-arn" [label = "output.public-ec2-arn", shape = "note"]
                        "[root] output.public-ec2-private_ip" [label = "output.public-ec2-private_ip", shape = "note"]
                        "[root] output.public-ec2-public_ip" [label = "output.public-ec2-public_ip", shape = "note"]
                        "[root] provider[\"registry.terraform.io/hashicorp/aws\"]" [label = "provider[\"registry.terraform.io/hashicorp/aws\"]", shape = "diamond"]
                        "[root] provider[\"registry.terraform.io/hashicorp/template\"]" [label = "provider[\"registry.terraform.io/hashicorp/template\"]", shape = "diamond"]
                        "[root] var.AMIS" [label = "var.AMIS", shape = "note"]
                        "[root] var.AWS_ACCESS_KEY" [label = "var.AWS_ACCESS_KEY", shape = "note"]
                        "[root] var.AWS_REGION" [label = "var.AWS_REGION", shape = "note"]
                        "[root] var.AWS_SECRET_KEY" [label = "var.AWS_SECRET_KEY", shape = "note"]
                        "[root] var.PATH_TO_PRIVATE_KEY" [label = "var.PATH_TO_PRIVATE_KEY", shape = "note"]
                        "[root] var.PATH_TO_PUBLIC_KEY" [label = "var.PATH_TO_PUBLIC_KEY", shape = "note"]
                        "[root] aws_eip.nat (expand)" -> "[root] provider[\"registry.terraform.io/hashicorp/aws\"]"
                        "[root] aws_instance.public-ec2 (expand)" -> "[root] aws_key_pair.mykeypair (expand)"
                        "[root] aws_instance.public-ec2 (expand)" -> "[root] aws_security_group.allow-http (expand)"
                        "[root] aws_instance.public-ec2 (expand)" -> "[root] aws_security_group.allow-ssh (expand)"
                        "[root] aws_instance.public-ec2 (expand)" -> "[root] aws_subnet.main-public-1 (expand)"
                        "[root] aws_instance.public-ec2 (expand)" -> "[root] data.template_cloudinit_config.cloudinit-startup-script (expand)"
                        "[root] aws_instance.public-ec2 (expand)" -> "[root] var.AMIS"
                        "[root] aws_internet_gateway.main-gw (expand)" -> "[root] aws_vpc.main (expand)"
                        "[root] aws_key_pair.mykeypair (expand)" -> "[root] provider[\"registry.terraform.io/hashicorp/aws\"]"
                        "[root] aws_key_pair.mykeypair (expand)" -> "[root] var.PATH_TO_PUBLIC_KEY"
                        "[root] aws_nat_gateway.nat-gw (expand)" -> "[root] aws_eip.nat (expand)"
                        "[root] aws_nat_gateway.nat-gw (expand)" -> "[root] aws_internet_gateway.main-gw (expand)"
                        "[root] aws_nat_gateway.nat-gw (expand)" -> "[root] aws_subnet.main-public-1 (expand)"
                        "[root] aws_route_table.main-private (expand)" -> "[root] aws_nat_gateway.nat-gw (expand)"
                        "[root] aws_route_table.main-public (expand)" -> "[root] aws_internet_gateway.main-gw (expand)"
                        "[root] aws_route_table_association.main-private-1-a (expand)" -> "[root] aws_route_table.main-private (expand)"
                        "[root] aws_route_table_association.main-private-1-a (expand)" -> "[root] aws_subnet.main-private-1 (expand)"
                        "[root] aws_route_table_association.main-public-1-a (expand)" -> "[root] aws_route_table.main-public (expand)"
                        "[root] aws_route_table_association.main-public-1-a (expand)" -> "[root] aws_subnet.main-public-1 (expand)"
                        "[root] aws_security_group.allow-http (expand)" -> "[root] aws_vpc.main (expand)"
                        "[root] aws_security_group.allow-ssh (expand)" -> "[root] aws_vpc.main (expand)"
                        "[root] aws_subnet.main-private-1 (expand)" -> "[root] aws_vpc.main (expand)"
                        "[root] aws_subnet.main-public-1 (expand)" -> "[root] aws_vpc.main (expand)"
                        "[root] aws_vpc.main (expand)" -> "[root] provider[\"registry.terraform.io/hashicorp/aws\"]"
                        "[root] data.template_cloudinit_config.cloudinit-startup-script (expand)" -> "[root] data.template_file.shell-script (expand)"
                        "[root] data.template_file.shell-script (expand)" -> "[root] provider[\"registry.terraform.io/hashicorp/template\"]"
                        "[root] meta.count-boundary (EachMode fixup)" -> "[root] aws_route_table_association.main-private-1-a (expand)"
                        "[root] meta.count-boundary (EachMode fixup)" -> "[root] aws_route_table_association.main-public-1-a (expand)"
                        "[root] meta.count-boundary (EachMode fixup)" -> "[root] output.aws_eip-nat-public_ip"
                        "[root] meta.count-boundary (EachMode fixup)" -> "[root] output.aws_nat_gateway-nat-gw-public_ip"
                        "[root] meta.count-boundary (EachMode fixup)" -> "[root] output.public-ec2-arn"
                        "[root] meta.count-boundary (EachMode fixup)" -> "[root] output.public-ec2-private_ip"
                        "[root] meta.count-boundary (EachMode fixup)" -> "[root] output.public-ec2-public_ip"
                        "[root] meta.count-boundary (EachMode fixup)" -> "[root] var.PATH_TO_PRIVATE_KEY"
                        "[root] output.aws_eip-nat-public_ip" -> "[root] aws_eip.nat (expand)"
                        "[root] output.aws_nat_gateway-nat-gw-public_ip" -> "[root] aws_nat_gateway.nat-gw (expand)"
                        "[root] output.public-ec2-arn" -> "[root] aws_instance.public-ec2 (expand)"
                        "[root] output.public-ec2-private_ip" -> "[root] aws_instance.public-ec2 (expand)"
                        "[root] output.public-ec2-public_ip" -> "[root] aws_instance.public-ec2 (expand)"
                        "[root] provider[\"registry.terraform.io/hashicorp/aws\"] (close)" -> "[root] aws_instance.public-ec2 (expand)"
                        "[root] provider[\"registry.terraform.io/hashicorp/aws\"] (close)" -> "[root] aws_route_table_association.main-private-1-a (expand)"
                        "[root] provider[\"registry.terraform.io/hashicorp/aws\"] (close)" -> "[root] aws_route_table_association.main-public-1-a (expand)"
                        "[root] provider[\"registry.terraform.io/hashicorp/aws\"]" -> "[root] var.AWS_ACCESS_KEY"
                        "[root] provider[\"registry.terraform.io/hashicorp/aws\"]" -> "[root] var.AWS_REGION"
                        "[root] provider[\"registry.terraform.io/hashicorp/aws\"]" -> "[root] var.AWS_SECRET_KEY"
                        "[root] provider[\"registry.terraform.io/hashicorp/template\"] (close)" -> "[root] data.template_cloudinit_config.cloudinit-startup-script (expand)"
                        "[root] root" -> "[root] meta.count-boundary (EachMode fixup)"
                        "[root] root" -> "[root] provider[\"registry.terraform.io/hashicorp/aws\"] (close)"
                        "[root] root" -> "[root] provider[\"registry.terraform.io/hashicorp/template\"] (close)"
                }
        }

The output of terraform graph is in the DOT format, which can easily be converted to an image by making use of dot provided by GraphViz:

        $ terraform graph | dot -Tsvg > graph.svg



![graph](/images/graph.JPG)        

### terraform taint

The terraform taint command manually marks a Terraform-managed resource as tainted, forcing it to be destroyed and recreated on the next apply


**Example**

To demo this command , lets assume we have below resources already created.

        $ terraform output
        back-end-arn = "arn:aws:ec2:us-east-1:119956859268:instance/i-063676a4bbdfc6436" 
        back-end-public_ip = "52.90.54.163"
        front-end-arn = "arn:aws:ec2:us-east-1:119956859268:instance/i-059c60976c894caa9"
        front-end-public_ip = "52.91.96.108"

Now if we perform apply or check the plan again....  we can see no new resource are created.        

        $ terraform plan
        aws_security_group.instance-security-group: Refreshing state... [id=sg-0b6b8eb2a476919d5]
        aws_instance.back-end: Refreshing state... [id=i-063676a4bbdfc6436]
        aws_instance.front-end[0]: Refreshing state... [id=i-059c60976c894caa9]

        No changes. Infrastructure is up-to-date.

        This means that Terraform did not detect any differences between your
        configuration and real physical resources that exist. As a result, no
        actions need to be performed.


        $ terraform apply
        aws_security_group.instance-security-group: Refreshing state... [id=sg-0b6b8eb2a476919d5]
        aws_instance.front-end[0]: Refreshing state... [id=i-059c60976c894caa9]
        aws_instance.back-end: Refreshing state... [id=i-063676a4bbdfc6436]    

        Apply complete! Resources: 0 added, 0 changed, 0 destroyed.

        Outputs:

        back-end-arn = "arn:aws:ec2:us-east-1:119956859268:instance/i-063676a4bbdfc6436"
        back-end-public_ip = "52.90.54.163"
        front-end-arn = "arn:aws:ec2:us-east-1:119956859268:instance/i-059c60976c894caa9"
        front-end-public_ip = "52.91.96.108"


now lets apply taint on **aws_instance.back-end**

        $ terraform taint aws_instance.back-end
        Resource instance aws_instance.back-end has been marked as tainted.

Apply plan post taint 

        $ terraform plan
        aws_security_group.instance-security-group: Refreshing state... [id=sg-0b6b8eb2a476919d5]
        aws_instance.back-end: Refreshing state... [id=i-063676a4bbdfc6436]
        aws_instance.front-end[0]: Refreshing state... [id=i-059c60976c894caa9]

        An execution plan has been generated and is shown below.
        Resource actions are indicated with the following symbols:
        -/+ destroy and then create replacement

        Terraform will perform the following actions:

        # aws_instance.back-end is tainted, so must be replaced
        -/+ resource "aws_instance" "back-end" {
            ~ arn                          = "arn:aws:ec2:us-east-1:119956859268:instance/i-063676a4bbdfc6436" -> (known after apply)
            ~ associate_public_ip_address  = true -> (known after apply)
            ~ availability_zone            = "us-east-1c" -> (known after apply)
            ~ cpu_core_count               = 1 -> (known after apply)
            ~ cpu_threads_per_core         = 1 -> (known after apply)
            - disable_api_termination      = false -> null
            - ebs_optimized                = false -> null
            - hibernation                  = false -> null
            + host_id                      = (known after apply)
            ~ id                           = "i-063676a4bbdfc6436" -> (known after apply)
            ~ instance_state               = "running" -> (known after apply)
            ~ ipv6_address_count           = 0 -> (known after apply)
            ~ ipv6_addresses               = [] -> (known after apply)
            + key_name                     = (known after apply)
            - monitoring                   = false -> null
            + outpost_arn                  = (known after apply)
            + password_data                = (known after apply)
            + placement_group              = (known after apply)
            ~ primary_network_interface_id = "eni-09c8630a4d547e9ad" -> (known after apply)
            ~ private_dns                  = "ip-172-31-16-232.ec2.internal" -> (known after apply)
            ~ private_ip                   = "172.31.16.232" -> (known after apply)
            ~ public_dns                   = "ec2-52-90-54-163.compute-1.amazonaws.com" -> (known after apply)
            ~ public_ip                    = "52.90.54.163" -> (known after apply)
            ~ secondary_private_ips        = [] -> (known after apply)
            ~ security_groups              = [
                - "instance-security-group",
                ] -> (known after apply)
            ~ subnet_id                    = "subnet-471a380a" -> (known after apply)
                tags                         = {
                    "Name"        = "back-end"
                    "component"   = "frontend"
                    "environment" = "production"
                }
               <<...truncated the output ...>> 
            }

        Plan: 1 to add, 0 to change, 1 to destroy.

        Changes to Outputs:
        ~ back-end-arn       = "arn:aws:ec2:us-east-1:119956859268:instance/i-063676a4bbdfc6436" -> (known after apply)
        ~ back-end-public_ip = "52.90.54.163" -> (known after apply)

        ------------------------------------------------------------------------

        Note: You didn't specify an "-out" parameter to save this plan, so Terraform
        can't guarantee that exactly these actions will be performed if
        "terraform apply" is subsequently run.

Here you can see post applying the taint on **aws_instance.back-end** , its going to be destoryed and re-created.

lets do untaint.

        $ terraform untaint aws_instance.back-end
        Resource instance aws_instance.back-end has been successfully untainted.

### terraform workspace

Terraform workspace allows to manage/store seprate env spepcific [like dev/uat/prod] state for the resources created with single set of parameterized configuration files. 

As our main goal is to have the same infrastructre created for all the enviroments using single set of configuration files. we might have some difference in enviorment like they can be in different region, or using different accounts. 

**The persistent data stored in the backend belongs to a workspace. Initially the backend has only one workspace, called "default", and thus there is only one Terraform state associated with that configuration.**


![workspace](images/Terraform-workspace.JPG)

refer to aws-ec2-workspace. 

In this example we will be having 3 workspaces dev , uat and prod and 3 different tfvar files dev.tfvars,uat.tfvars and prod.tfvars 

#### Workspace commands

        $ terraform workspace
        Usage: terraform workspace

        new, list, show, select and delete Terraform workspaces.

#### Workspace commands - list

 list the available workspace.

        $ terraform workspace list
        * default

#### Workspace commands - show

show the current workspace name

        $ terraform workspace show
        default

        $ terraform workspace show
        prod

#### Workspace commands - new

Create a new workspace and select it.

        $ terraform workspace new dev
        Created and switched to workspace "dev"!

        You're now on a new, empty workspace. Workspaces isolate their state,
        so if you run "terraform plan" Terraform will not see any existing state
        for this configuration.

        $ terraform workspace list
        default
        * dev    

        $ terraform workspace new uat
        Created and switched to workspace "uat"!

        You're now on a new, empty workspace. Workspaces isolate their state,
        so if you run "terraform plan" Terraform will not see any existing state
        for this configuration.

        $ terraform workspace list
        default
        dev
        * uat

        $ terraform workspace new prod
        Created and switched to workspace "prod"!

        You're now on a new, empty workspace. Workspaces isolate their state,
        so if you run "terraform plan" Terraform will not see any existing state
        for this configuration.

        $ terraform workspace list
        default
        dev
        * prod
        uat

This will also create seprate directories to store the env specific state     
        
        $ tree terraform.tfstate.d
        terraform.tfstate.d
        |-- dev
        |-- prod
        `-- uat

#### Workspace commands - select

select option allows to select the specific workspace 

        $ terraform workspace list
        default
        dev    
        * prod   
        uat    

        $ terraform workspace select dev
        Switched to workspace "dev".

        $ terraform workspace list
        default
        * dev
        prod
        uat

**lets apply it on dev work space.**


        $ terraform apply -var-file dev.tfvars 
        .
        .
        .
        .
        Plan: 3 to add, 0 to change, 0 to destroy.

        Changes to Outputs:
        + back-end-arn        = (known after apply)
        + back-end-public_ip  = (known after apply)
        + back-end-tags       = {
            + "Name"      = "back-end-dev-instance"
            + "component" = "backend"
            }
        + front-end-arn       = (known after apply)
        + front-end-public_ip = (known after apply)
        + front-end-tags      = {
            + "Name"      = "front-end-dev-instance"
            + "component" = "frontend"
            }

        Do you want to perform these actions in workspace "dev"?
        Terraform will perform the actions described above.
        Only 'yes' will be accepted to approve.

        Enter a value: yes

        .
        .
        .
        .

        Apply complete! Resources: 3 added, 0 changed, 0 destroyed.

        Outputs:

        back-end-ami = "ami-0915bcb5fa77e4892"
        back-end-arn = "arn:aws:ec2:us-east-1:119956859268:instance/i-06dc4fd0f29b83442"
        back-end-public_ip = "54.90.106.194"
        back-end-tags = tomap({
        "Name" = "back-end-dev-instance"
        "component" = "backend"
        })
        front-end-ami = "ami-0915bcb5fa77e4892"
        front-end-arn = "arn:aws:ec2:us-east-1:119956859268:instance/i-0cd8d4c833cba8458"
        front-end-public_ip = "54.83.100.110"
        front-end-tags = tomap({
        "Name" = "front-end-dev-instance"
        "component" = "frontend"
        })

As we can see here the tags for the both the instance has dev word appended. Also dev workspace state is stored in terraform.tfstate.d/dev folder.

        $ tree terraform.tfstate.d
        terraform.tfstate.d
        |-- dev
        |   `-- terraform.tfstate
        |-- prod
        `-- uat

**Change the workspace to uat and apply.**


        $ terraform workspace select uat
        Switched to workspace "uat".

        $ terraform apply -var-file uat.tfvars 
        .
        .
        .
        Plan: 3 to add, 0 to change, 0 to destroy.

        Changes to Outputs:
        + back-end-ami        = "ami-09246ddb00c7c4fef"
        + back-end-arn        = (known after apply)
        + back-end-public_ip  = (known after apply)
        + back-end-tags       = {
            + "Name"      = "back-end-uat-instance"
            + "component" = "backend"
            }
        + front-end-ami       = "ami-09246ddb00c7c4fef"
        + front-end-arn       = (known after apply)
        + front-end-public_ip = (known after apply)
        + front-end-tags      = {
            + "Name"      = "front-end-uat-instance"
            + "component" = "frontend"
            }

        Do you want to perform these actions in workspace "uat"?
        Terraform will perform the actions described above.
        Only 'yes' will be accepted to approve.

        Enter a value: yes

        .
        .
        .

        Apply complete! Resources: 3 added, 0 changed, 0 destroyed.

        Outputs:

        back-end-ami = "ami-09246ddb00c7c4fef"
        back-end-arn = "arn:aws:ec2:us-east-2:119956859268:instance/i-068bd96e2621acb03"
        back-end-public_ip = "3.141.12.209"
        back-end-tags = tomap({
        "Name" = "back-end-uat-instance"
        "component" = "backend"
        })
        front-end-ami = "ami-09246ddb00c7c4fef"
        front-end-arn = "arn:aws:ec2:us-east-2:119956859268:instance/i-02c03cc4c6ef2a02e"
        front-end-public_ip = "18.191.84.194"
        front-end-tags = tomap({
        "Name" = "front-end-uat-instance"
        "component" = "frontend"
        })

here differnt region/ami is selected based on -var-file also the intance name appended with uat.

and seprate state for uat


    $ tree terraform.tfstate.d/
    terraform.tfstate.d/
    |-- dev
    |   |-- terraform.tfstate       
        |-- prod
    `-- uat
        `-- terraform.tfstate

    3 directories, 2 files 

#### Workspace commands - delete

- **delete prod workspace** - yes we can dleete it as there is no state stored.
- **delete uat workspace** - can;t delete and we have state stored, so we need to destory the resources then delete it.
- **Before applying destroy**, select the correct workspace. 
- **Before applying workspace delete**, make sure workspace to be delete is not active.
- default workspace can not be deleted

```
    $ terraform workspace delete prod
    Deleted workspace "prod"!

    $ terraform workspace delete uat
    Workspace "uat" is not empty.

    Deleting "uat" can result in dangling resources: resources that
    exist but are no longer manageable by Terraform. Please destroy
    these resources first.  If you want to delete this workspace
    anyway and risk dangling resources, use the '-force' flag.

    $ terraform workspace select uat
    Switched to workspace "uat".

    $ terraform destroy -var-file uat.tfvars 
    .
    .
    .
        
    Do you really want to destroy all resources in workspace "uat"?
    Terraform will destroy all your managed infrastructure, as shown above.
    There is no undo. Only 'yes' will be accepted to confirm.

    Enter a value: yes
    .
    .
    .
    Destroy complete! Resources: 3 destroyed.

    $ terraform workspace delete uat
    Workspace "uat" is your active workspace.

    You cannot delete the currently active workspace. Please switch
    to another workspace and try again.

    $ terraform workspace select default
    Switched to workspace "default".

    $ terraform workspace delete uat
    Deleted workspace "uat"!
```


### terraform state

* Terraform must store state about your managed infrastructure and configuration. This state is used by Terraform to map real world resources to your configuration, keep track of metadata, and to improve performance for large infrastructures.

* This state is stored by default in a local file named **terraform.tfstate**, but it can also be stored remotely, which works better in a team environment.

* The Terraform state subcommands all work with remote state just as if it was local state. Reads and writes may take longer than normal as each read and each write do a full network roundtrip.

* All terraform state subcommands that modify the state write backup files. The path of these backup file can be controlled with -backup.

* Subcommands that are read-only (such as list) do not write any backup files since they aren't modifying the state

#### terraform state commands

    $ terraform state
    Usage: terraform state <subcommand> [options] [args]

    This command has subcommands for advanced state management.

    These subcommands can be used to slice and dice the Terraform state.
    This is sometimes necessary in advanced cases. For your safety, all
    state management commands that modify the state create a timestamped
    backup of the state prior to making modifications.

    The structure and output of the commands is specifically tailored to work
    well with the common Unix utilities such as grep, awk, etc. We recommend
    using those tools to perform more advanced state tasks.

    Subcommands:
        list                List resources in the state
        mv                  Move an item in the state
        pull                Pull current state and output to stdout
        push                Update remote state from a local state file
        replace-provider    Replace provider in the state
        rm                  Remove instances from the state
        show                Show a resource in the state

#### terraform state list

The command will list all resources in the state file matching the given addresses (if any). If no addresses are given, all resources are listed.

        $ terraform state list
        aws_instance.back-end
        aws_instance.front-end
        aws_security_group.instance-security-group

#### terraform state show

The command will show the attributes of a single resource in the state file that matches the given address.

        $ terraform state show aws_instance.back-end
        # aws_instance.back-end:
        resource "aws_instance" "back-end" {
            ami                          = "ami-0915bcb5fa77e4892"
            arn                          = "arn:aws:ec2:us-east-1:119956859268:instance/i-0ae685b927586fa73"
            associate_public_ip_address  = true
            availability_zone            = "us-east-1c"
            cpu_core_count               = 1
            cpu_threads_per_core         = 1
            disable_api_termination      = false
            ebs_optimized                = false
            get_password_data            = false
            hibernation                  = false
            id                           = "i-0ae685b927586fa73"
            instance_state               = "running"
            instance_type                = "t2.micro"
            ipv6_address_count           = 0
            ipv6_addresses               = []
            monitoring                   = false
            primary_network_interface_id = "eni-032b15a644d4846a4"
            private_dns                  = "ip-172-31-21-252.ec2.internal"
            private_ip                   = "172.31.21.252"
            public_dns                   = "ec2-34-228-9-184.compute-1.amazonaws.com"
            public_ip                    = "34.228.9.184"
            secondary_private_ips        = []
            security_groups              = [
                "instance-security-group",
            ]
            source_dest_check            = true
            subnet_id                    = "subnet-471a380a"
            tags                         = {
                "Name"      = "back-end"
                "component" = "backend"
            }
            tenancy                      = "default"
            vpc_security_group_ids       = [
                "sg-0075a225ab7b64236",
            ]

            credit_specification {
                cpu_credits = "standard"
            }

            enclave_options {
                enabled = false
            }

            metadata_options {
                http_endpoint               = "enabled"
                http_put_response_hop_limit = 1
                http_tokens                 = "optional"
            }

            root_block_device {
                delete_on_termination = true
                device_name           = "/dev/xvda"
                encrypted             = false
                iops                  = 100
                tags                  = {}
                throughput            = 0
                volume_id             = "vol-062b91d68768d949a"
                volume_size           = 8
                volume_type           = "gp2"
            }
        }


#### terraform refresh


The terraform refresh command is used to reconcile the state Terraform knows about (via its state file) with the real-world infrastructure. This can be used to detect any drift from the last-known state, and to update the state file.

This does not modify infrastructure, but does modify the state file. If the state is changed, this may cause changes to occur during the next plan or apply.


        $ terraform refresh
        aws_security_group.instance-security-group: Refreshing state... [id=sg-0075a225ab7b64236]
        aws_instance.back-end: Refreshing state... [id=i-0ae685b927586fa73]
        aws_instance.front-end: Refreshing state... [id=i-050aa3ed359a95b11]

        Outputs:

        back-end-arn = "arn:aws:ec2:us-east-1:119956859268:instance/i-0ae685b927586fa73"
        back-end-public_ip = "34.228.9.184"
        front-end-arn = "arn:aws:ec2:us-east-1:119956859268:instance/i-050aa3ed359a95b11"
        front-end-public_ip = "54.165.254.135"

#### terraform state mv

This command will move an item matched by the address given to the destination address. This command can also move to a destination address in a completely different state file.

This can be used for simple resource renaming, moving items to and from a module, moving entire modules, and more. And because this command can also move data to a completely new state, it can also be used for refactoring one configuration into multiple separately managed Terraform configurations.

This command will output a backup copy of the state prior to saving any changes. The backup cannot be disabled. Due to the destructive nature of this command, backups are required.

If you're moving an item to a different state file, a backup will be created for each state file.

This commond will updated the resource on existing "terraform.tfstate" file

```sh
    $ terraform state mv aws_instance.front-end aws_instance.front-end-server
    Move "aws_instance.front-end" to "aws_instance.front-end-server"
    Successfully moved 1 object(s).
```
This commond will extract the  resource and place on a new "terraform.tfstate" file provided with **-state-out**

```sh
    $ terraform state mv -state-out=terraform-ec2.tfstate  aws_instance.front-end aws_instance.front-end-server
    Move "aws_instance.front-end" to "aws_instance.front-end-server"
    Successfully moved 1 object(s).
```

#### terraform state rm 

State rm command is used to remove resource from terraform state. Resource won't be destoryed on provider , but it
won't be no longer managed by terraform. So after applying state rm on any resource if destroy is applied, resource won't be deleted on provider.

```
    $ terraform state list
    aws_instance.back-end
    aws_instance.front-end
    aws_security_group.instance-security-group

    
    $ terraform state rm aws_instance.back-end
    Removed aws_instance.back-end
    Successfully removed 1 resource instance(s).
```


#### terraform state pull 

The terraform state pull command is used to manually download and output the state from remote state. This command also works with local state.

lets apply the at /aws-ec2

```

    $ terraform apply

    An execution plan has been generated and is shown below.
    Resource actions are indicated with the following symbols:
    + create

    Terraform will perform the following actions:

    .
    .
    .
    .

    Plan: 3 to add, 0 to change, 0 to destroy.

    Changes to Outputs:
    + back-end-arn        = (known after apply)
    + back-end-public_ip  = (known after apply)
    + front-end-arn       = (known after apply)
    + front-end-public_ip = (known after apply)

    Do you want to perform these actions?
    Terraform will perform the actions described above.
    Only 'yes' will be accepted to approve.

    Enter a value: yes

    .
    .
    .
    .

    Apply complete! Resources: 3 added, 0 changed, 0 destroyed.

    Outputs:

    back-end-arn = "arn:aws:ec2:us-east-1:119956859268:instance/i-0de5335e3ae34b203"
    back-end-public_ip = "3.86.138.63"
    front-end-arn = "arn:aws:ec2:us-east-1:119956859268:instance/i-0a66277aa1e4a5753"
    front-end-public_ip = "3.95.13.128"

```

now try to pull the state

```
    $ terraform state pull
    {
    "version": 4,
    "terraform_version": "0.14.6",
    "serial": 7,
    "lineage": "43fa88cd-12e6-5e3a-ab11-f2f8d8d6bdfa",
    "outputs": {
        "back-end-arn": {
        "value": "arn:aws:ec2:us-east-1:119956859268:instance/i-0de5335e3ae34b203",
        "type": "string"
        },
        "back-end-public_ip": {
        "value": "3.86.138.63",
        "type": "string"
        },
        "front-end-arn": {
        "value": "arn:aws:ec2:us-east-1:119956859268:instance/i-0a66277aa1e4a5753",
        "type": "string"
        },
        "front-end-public_ip": {
        "value": "3.95.13.128",
        "type": "string"
        }
    },
    "resources": [
        {
        "mode": "managed",
        "type": "aws_instance",
        "name": "back-end",
        "provider": "provider[\"registry.terraform.io/hashicorp/aws\"]",
        "instances": [
            {
            "schema_version": 1,
            "attributes": {
                "ami": "ami-0915bcb5fa77e4892",
                "arn": "arn:aws:ec2:us-east-1:119956859268:instance/i-0de5335e3ae34b203",
                "associate_public_ip_address": true,
                "availability_zone": "us-east-1b",
                "cpu_core_count": 1,
                "cpu_threads_per_core": 1,
                "credit_specification": [
                {
                    "cpu_credits": "standard"
                }
                ],
                "disable_api_termination": false,
                "ebs_block_device": [],
                "ebs_optimized": false,
                "enclave_options": [
                {
                    "enabled": false
                }
                ],
                "ephemeral_block_device": [],
                "get_password_data": false,
                "hibernation": false,
                "host_id": null,
                "iam_instance_profile": "",
                "id": "i-0de5335e3ae34b203",
                "instance_initiated_shutdown_behavior": null,
                "instance_state": "running",
                "instance_type": "t2.micro",
                "ipv6_address_count": 0,
                "ipv6_addresses": [],
                "key_name": "",
                "metadata_options": [
                {
                    "http_endpoint": "enabled",
                    "http_put_response_hop_limit": 1,
                    "http_tokens": "optional"
                }
                ],
                "monitoring": false,
                "network_interface": [],
                "outpost_arn": "",
                "password_data": "",
                "placement_group": "",
                "primary_network_interface_id": "eni-087427d13300ce550",
                "private_dns": "ip-172-31-92-126.ec2.internal",
                "private_ip": "172.31.92.126",
                "public_dns": "ec2-3-86-138-63.compute-1.amazonaws.com",
                "public_ip": "3.86.138.63",
                "root_block_device": [
                {
                    "delete_on_termination": true,
                    "device_name": "/dev/xvda",
                    "encrypted": false,
                    "iops": 100,
                    "kms_key_id": "",
                    "tags": {},
                    "throughput": 0,
                    "volume_id": "vol-0e15eff673c66e72e",
                    "volume_size": 8,
                    "volume_type": "gp2"
                }
                ],
                "secondary_private_ips": [],
                "security_groups": [
                "instance-security-group"
                ],
                "source_dest_check": true,
                "subnet_id": "subnet-926af3b3",
                "tags": {
                "Name": "back-end",
                "component": "backend"
                },
                "tenancy": "default",
                "timeouts": null,
                "user_data": null,
                "user_data_base64": null,
                "volume_tags": null,
                "vpc_security_group_ids": [
                "sg-0bd2535c102712408"
                ]
            },
            "sensitive_attributes": [],
            "private": "********",
            "dependencies": [
                "aws_security_group.instance-security-group"
            ]
            }
        ]
        },
        {
        "mode": "managed",
        "type": "aws_instance",
        "name": "front-end",
        "provider": "provider[\"registry.terraform.io/hashicorp/aws\"]",
        "instances": [
            {
            "schema_version": 1,
            "attributes": {
                "ami": "ami-0915bcb5fa77e4892",
                "arn": "arn:aws:ec2:us-east-1:119956859268:instance/i-0a66277aa1e4a5753",
                "associate_public_ip_address": true,
                "availability_zone": "us-east-1b",
                "cpu_core_count": 1,
                "cpu_threads_per_core": 1,
                "credit_specification": [
                {
                    "cpu_credits": "standard"
                }
                ],
                "disable_api_termination": false,
                "ebs_block_device": [],
                "ebs_optimized": false,
                "enclave_options": [
                {
                    "enabled": false
                }
                ],
                "ephemeral_block_device": [],
                "get_password_data": false,
                "hibernation": false,
                "host_id": null,
                "iam_instance_profile": "",
                "id": "i-0a66277aa1e4a5753",
                "instance_initiated_shutdown_behavior": null,
                "instance_state": "running",
                "instance_type": "t2.micro",
                "ipv6_address_count": 0,
                "ipv6_addresses": [],
                "key_name": "",
                "metadata_options": [
                {
                    "http_endpoint": "enabled",
                    "http_put_response_hop_limit": 1,
                    "http_tokens": "optional"
                }
                ],
                "monitoring": false,
                "network_interface": [],
                "outpost_arn": "",
                "password_data": "",
                "placement_group": "",
                "primary_network_interface_id": "eni-00fe1709fc2b5ad80",
                "private_dns": "ip-172-31-82-24.ec2.internal",
                "private_ip": "172.31.82.24",
                "public_dns": "ec2-3-95-13-128.compute-1.amazonaws.com",
                "public_ip": "3.95.13.128",
                "root_block_device": [
                {
                    "delete_on_termination": true,
                    "device_name": "/dev/xvda",
                    "encrypted": false,
                    "iops": 100,
                    "kms_key_id": "",
                    "tags": {},
                    "throughput": 0,
                    "volume_id": "vol-0e2cb5c98bb7b2fd5",
                    "volume_size": 8,
                    "volume_type": "gp2"
                }
                ],
                "secondary_private_ips": [],
                "security_groups": [
                "instance-security-group"
                ],
                "source_dest_check": true,
                "subnet_id": "subnet-926af3b3",
                "tags": {
                "Name": "front-end",
                "component": "frontend"
                },
                "tenancy": "default",
                "timeouts": null,
                "user_data": null,
                "user_data_base64": null,
                "volume_tags": null,
                "vpc_security_group_ids": [
                "sg-0bd2535c102712408"
                ]
            },
            "sensitive_attributes": [],
            "private": "**********",
            "dependencies": [
                "aws_security_group.instance-security-group"
            ]
            }
        ]
        },
        {
        "mode": "managed",
        "type": "aws_security_group",
        "name": "instance-security-group",
        "provider": "provider[\"registry.terraform.io/hashicorp/aws\"]",
        "instances": [
            {
            "schema_version": 1,
            "attributes": {
                "arn": "arn:aws:ec2:us-east-1:119956859268:security-group/sg-0bd2535c102712408",
                "description": "security group that allows ssh/http and all egress traffic",
                "egress": [
                {
                    "cidr_blocks": [
                    "0.0.0.0/0"
                    ],
                    "description": "",
                    "from_port": 0,
                    "ipv6_cidr_blocks": [],
                    "prefix_list_ids": [],
                    "protocol": "-1",
                    "security_groups": [],
                    "self": false,
                    "to_port": 0
                }
                ],
                "id": "sg-0bd2535c102712408",
                "ingress": [
                {
                    "cidr_blocks": [
                    "0.0.0.0/0",
                    "127.0.0.1/32"
                    ],
                    "description": "",
                    "from_port": 80,
                    "ipv6_cidr_blocks": [],
                    "prefix_list_ids": [],
                    "protocol": "tcp",
                    "security_groups": [],
                    "self": false,
                    "to_port": 80
                },
                {
                    "cidr_blocks": [
                    "0.0.0.0/0"
                    ],
                    "description": "",
                    "from_port": 22,
                    "ipv6_cidr_blocks": [],
                    "prefix_list_ids": [],
                    "protocol": "tcp",
                    "security_groups": [],
                    "self": false,
                    "to_port": 22
                },
                {
                    "cidr_blocks": [
                    "0.0.0.0/0"
                    ],
                    "description": "",
                    "from_port": 443,
                    "ipv6_cidr_blocks": [],
                    "prefix_list_ids": [],
                    "protocol": "tcp",
                    "security_groups": [],
                    "self": false,
                    "to_port": 443
                },
                {
                    "cidr_blocks": [
                    "0.0.0.0/0"
                    ],
                    "description": "",
                    "from_port": 8080,
                    "ipv6_cidr_blocks": [],
                    "prefix_list_ids": [],
                    "protocol": "tcp",
                    "security_groups": [],
                    "self": false,
                    "to_port": 8080
                }
                ],
                "name": "instance-security-group",
                "name_prefix": "",
                "owner_id": "119956859268",
                "revoke_rules_on_delete": false,
                "tags": null,
                "timeouts": null,
                "vpc_id": "vpc-bf1ab5c2"
            },
            "sensitive_attributes": [],
            "private": "**********="
            }
        ]
        }
    ]
    }
```

#### terraform state push 

The terraform state push command is used to manually upload a local state file to remote state. This command also works with local state.

This command should rarely be used. It is meant only as a utility in case manual intervention is necessary with the remote state.

```sh

    $ terraform state push terraform.tfstate

```


### terraform refresh

Update the state file of your infrastructure with metadata that matches the physical resources they are tracking.
This will not modify your infrastructure, but it can modify your state file to update metadata. This metadata might cause new changes to occur when you generate a plan or call apply next.

to understand this command, lets apply the /github-demo and pull state of "terraform-repo-sumitgupta28".

```sh

    $ terraform state list
    github_repository.terraform-repo-sumitgupta28
    github_repository.terraform-repo-sumitgupta28-test

    $ terraform state show github_repository.terraform-repo-sumitgupta28 | grep archived
        archived               = false
```

here we can see archived is false. Now lets go to github and update archived as true.

go to > Settings > Danger Zone > Archive this repository and do refresh command,

```
    $ terraform refresh
    github_repository.terraform-repo-sumitgupta28-test: Refreshing state... [id=terraform-repo-sumitgupta28-test]
    github_repository.terraform-repo-sumitgupta28: Refreshing state... [id=terraform-repo-sumitgupta28]

    Outputs:

    default_branch-1 = "main"
    default_branch-2 = "main"
    description-1 = "created via terraform"
    description-2 = "created via terraform[terraform-repo-sumitgupta28-test]"
    full_name-1 = "sumitgupta28/terraform-repo-sumitgupta28"
    full_name-2 = "sumitgupta28/terraform-repo-sumitgupta28-test"
    git_clone_url-1 = "git://github.com/sumitgupta28/terraform-repo-sumitgupta28.git"
    git_clone_url-2 = "git://github.com/sumitgupta28/terraform-repo-sumitgupta28-test.git"

    $ terraform state show github_repository.terraform-repo-sumitgupta28 | grep arc
        archived               = true

```

After refresh if we see the value of archived it becomes true as it pulled state from provider. 


#### terraform show

Reads and outputs a Terraform state or plan file in a human-readable form. 

**If no path is specified, the current state will be shown.**

```

Options:
  -no-color           If specified, output won't contain any color.
  -json               If specified, output the Terraform plan or state in
                      a machine-readable form.
```

to understand this lets go to **011-aws-create-s3** and run below plan command with -out parameter.

```sh
    $ terraform plan -out aws-s3.plan

    An execution plan has been generated and is shown below.
    Resource actions are indicated with the following symbols:
    + create

    Terraform will perform the following actions:

    # aws_s3_bucket.sumitgupta28-s3-backend will be created
    + resource "aws_s3_bucket" "sumitgupta28-s3-backend" {
        + acceleration_status         = (known after apply)
        + acl                         = "private"
        + arn                         = (known after apply)
        + bucket                      = "sumitgupta28-s3-backend"
        + bucket_domain_name          = (known after apply)
        + bucket_regional_domain_name = (known after apply)
        + force_destroy               = false
        + hosted_zone_id              = (known after apply)
        + id                          = (known after apply)
        + region                      = (known after apply)
        + request_payer               = (known after apply)
        + tags                        = {
            + "Environment" = "Dev"
            + "Name"        = "sumitgupta28-s3-backend"
            }
        + website_domain              = (known after apply)
        + website_endpoint            = (known after apply)

        + versioning {
            + enabled    = (known after apply)
            + mfa_delete = (known after apply)
            }
        }

    Plan: 1 to add, 0 to change, 0 to destroy.

    ------------------------------------------------------------------------

    This plan was saved to: aws-s3.plan

    To perform exactly these actions, run the following command to apply:
        terraform apply "aws-s3.plan"

```

This will create a plan file named as "aws-s3.plan". now lets use the show command to see the plan .

```sh 
    $ terraform show -json aws-s3.plan
    {"format_version":"0.1","terraform_version":"0.14.6","variables":{"AWS_ACCESS_KEY":{"value":"AKIARX3P4NGCKCPDBDPJ"},"AWS_REGION":{"value":"us-east-1"},"AWS_SECRET_KEY":{"value":"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"}},"planned_values":{"root_module":{"resources":[{"address":"aws_s3_bucket.sumitgupta28-s3-backend","mode":"managed","type":"aws_s3_bucket","name":"sumitgupta28-s3-backend","provider_name":"registry.terraform.io/hashicorp/aws","schema_version":0,"values":{"acl":"private","bucket":"sumitgupta28-s3-backend","bucket_prefix":null,"cors_rule":[],"force_destroy":false,"grant":[],"lifecycle_rule":[],"logging":[],"object_lock_configuration":[],"policy":null,"replication_configuration":[],"server_side_encryption_configuration":[],"tags":{"Environment":"Dev","Name":"sumitgupta28-s3-backend"},"website":[]}}]}},"resource_changes":[{"address":"aws_s3_bucket.sumitgupta28-s3-backend","mode":"managed","type":"aws_s3_bucket","name":"sumitgupta28-s3-backend","provider_name":"registry.terraform.io/hashicorp/aws","change":{"actions":["create"],"before":null,"after":{"acl":"private","bucket":"sumitgupta28-s3-backend","bucket_prefix":null,"cors_rule":[],"force_destroy":false,"grant":[],"lifecycle_rule":[],"logging":[],"object_lock_configuration":[],"policy":null,"replication_configuration":[],"server_side_encryption_configuration":[],"tags":{"Environment":"Dev","Name":"sumitgupta28-s3-backend"},"website":[]},"after_unknown":{"acceleration_status":true,"arn":true,"bucket_domain_name":true,"bucket_regional_domain_name":true,"cors_rule":[],"grant":[],"hosted_zone_id":true,"id":true,"lifecycle_rule":[],"logging":[],"object_lock_configuration":[],"region":true,"replication_configuration":[],"request_payer":true,"server_side_encryption_configuration":[],"tags":{},"versioning":true,"website":[],"website_domain":true,"website_endpoint":true}}}],"configuration":{"provider_config":{"aws":{"name":"aws","expressions":{"access_key":{"references":["var.AWS_ACCESS_KEY"]},"region":{"references":["var.AWS_REGION"]},"secret_key":{"references":["var.AWS_SECRET_KEY"]}}}},"root_module":{"resources":[{"address":"aws_s3_bucket.sumitgupta28-s3-backend","mode":"managed","type":"aws_s3_bucket","name":"sumitgupta28-s3-backend","provider_config_key":"aws","expressions":{"acl":{"constant_value":"private"},"bucket":{"constant_value":"sumitgupta28-s3-backend"},"tags":{"constant_value":{"Environment":"Dev","Name":"sumitgupta28-s3-backend"}}},"schema_version":0}],"variables":{"AWS_ACCESS_KEY":{},"AWS_REGION":{"default":"us-east-1"},"AWS_SECRET_KEY":{}}}}}

```
#### terraform get

- Downloads and installs modules needed for the configuration given by PATH.

- This recursively downloads all modules needed, such as modules imported by modules imported by the root and so on. If a module is already downloaded, it will not be redownloaded or checked for updates unless the -update flag is specified.

- Module installation also happens automatically by default as part of the "terraform init" command, so you should rarely need to run this command separately.


To see how this command works , lets to to "018-aws-modules" folder and run below commands. here can see we are using the different aws modules and and corresponding sources.

```sh
    $ grep 'module "' *.tf
    autoscaling.tf:module "onlineportal-autoscaling-group" {
    ec2-instance.tf:module "onlineportal-front-end-server" {
    ec2-instance.tf:module "onlineportal-back-end-server" { 
    security-group.tf:module "http-security-group" {        
    security-group.tf:module "ssh-security-group" {
    vpc.tf:module "sgsys-onlineportal-vpc" {

    $ grep 'source' *.tf
    autoscaling.tf:  source  = "terraform-aws-modules/autoscaling/aws"
    ec2-instance.tf:  source  = "terraform-aws-modules/ec2-instance/aws"
    ec2-instance.tf:  source  = "terraform-aws-modules/ec2-instance/aws"
    security-group.tf:  source  = "terraform-aws-modules/security-group/aws"
    security-group.tf:  source  = "terraform-aws-modules/security-group/aws"
    vpc.tf:  source     = "terraform-aws-modules/vpc/aws"
```

Now lets run the get command 

```sh
    $ terraform get
    Downloading terraform-aws-modules/security-group/aws 3.18.0 for http-security-group...
    - http-security-group in .terraform\modules\http-security-group
    Downloading terraform-aws-modules/autoscaling/aws 3.9.0 for onlineportal-autoscaling-group...
    - onlineportal-autoscaling-group in .terraform\modules\onlineportal-autoscaling-group
    Downloading terraform-aws-modules/ec2-instance/aws 2.17.0 for onlineportal-back-end-server...
    - onlineportal-back-end-server in .terraform\modules\onlineportal-back-end-server
    Downloading terraform-aws-modules/ec2-instance/aws 2.17.0 for onlineportal-front-end-server...
    - onlineportal-front-end-server in .terraform\modules\onlineportal-front-end-server
    Downloading terraform-aws-modules/vpc/aws 2.59.0 for sgsys-onlineportal-vpc...
    - sgsys-onlineportal-vpc in .terraform\modules\sgsys-onlineportal-vpc
    Downloading terraform-aws-modules/security-group/aws 3.18.0 for ssh-security-group...
    - ssh-security-group in .terraform\modules\ssh-security-group
```

Here we can seee it reading the module insturctions and downloading the modules and copying them 
in **.terraform\modules** folder.


#### terraform console

The terraform console  command is useful for testing interpolations before using them in configurations. Terraform console will read configured state even if it is remote.

Try Terraform expressions at an interactive command prompt


### terraform force unlock

[link](https://www.terraform.io/docs/cli/commands/force-unlock.html)

Manually unlock the state for the defined configuration.

This will not modify your infrastructure. This command removes the lock on the state for the current configuration. The behavior of this lock is dependent on the backend being used. Local state files cannot be unlocked by another process.


Just to demo , if you try to do apply and if state is locked due to some other process. you will see below error message.

```sh
    
    $ terraform apply

    Error: Error locking state: Error acquiring the state lock: Failed to read state file: The state file could not be read: read terread terraform.tfstate: The process cannot access the file because another process has locked a portion of the file.       

    Terraform acquires a state lock to protect the state from being written by multiple users at the same time. Please resolve the issue above and try again. For most commands, you can disable locking with the "-lock=false" flag, but this is not recommended.

```

Since i am doing this with local state. i will have **.terraform.tfstate.lock.info** and here the **ID** field will be needed for the unlocking. in case of s3 Backend with Dynamodb, this info will be stored in the Dynamodb. 

```sh
    $ cat .terraform.tfstate.lock.info 
    {"ID":"3edd7d9f-1795-6f16-1915-2b9c04bf42bc","Operation":"OperationTypeApply","Info":"","Who":"SUMITGUPTA\\Sumit@sumitgupta","Version":"0.14.6","Created":"2021-03-19T04:34:45.9266171Z","Path":"terraform.tfstate"}
```

Now if we try to unlock it , due to local it will get error "Local state cannot be unlocked by another process" , but if you have s3 Backend with Dynamodb , this will perform the unlock. 

```sh
    $ terraform force-unlock 3edd7d9f-1795-6f16-1915-2b9c04bf42bc
    Local state cannot be unlocked by another process
```

- import        Associate existing infrastructure with a Terraform resource
- refresh       Update the state to match remote systems
