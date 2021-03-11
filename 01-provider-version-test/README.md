# Terraform Providers

- Terraform uses providers to interface between the Terraform engine and the supported cloud platform.

- Providers are a logical abstraction of an upstream API. They are responsible for understanding API interactions and exposing resources.

- Providers are distributed separately from Terraform itself, and each provider has its own release cadence and version numbers.

- The Terraform [Registry](https://registry.terraform.io/browse/providers)  is the main directory of publicly available Terraform providers, and hosts providers for most major infrastructure platforms.


# How to Run 

- Here is [provider.tf](provider.tf) which list out few providers out of so many. 
- Here we can also see the different ways of providing versions for any provider.

## Terraform Provider Versioning

There are multiple ways to specify the provider version.

| Version                   | Possible Value                      |
| -------------             | -------------                       |
| >=1.0                     | Greater then equal to version 1.0   |
| <=1.0                     | Less then equal to version 1.0      |
| ~>2.0                     | Any Version in the 2.x range        |
| >=2.0,<=2.30              | Version between 2.10 and 2.30       |

```Terraform

    terraform {
        required_providers {
            aws = {
            source  = "hashicorp/aws"
            version = "~>2.0"
            }
            azurerm = {
            source  = "hashicorp/azurerm"
            version = ">=2.40"
            }

            google = {
            source  = "hashicorp/google"
            version = "<=3.50"
            }

            kubernetes = {
            source = "hashicorp/kubernetes"
            version = ">=2.0,<=3.0"
            }
        }
    }

```

## init Commond 

```sh
    $ terraform init

    Initializing the backend...

    Initializing provider plugins...
    - Finding hashicorp/aws versions matching "~> 2.0"...
    - Finding hashicorp/azurerm versions matching ">= 2.40.0"...
    - Finding hashicorp/google versions matching "<= 3.50.0"...
    - Finding hashicorp/kubernetes versions matching ">= 2.0.0, <= 3.0.0"...


    - Installing hashicorp/aws v2.70.0...
    - Installed hashicorp/aws v2.70.0 (signed by HashiCorp)
    - Installing hashicorp/azurerm v2.50.0...
    - Installed hashicorp/azurerm v2.50.0 (signed by HashiCorp)
    - Installing hashicorp/google v3.50.0...
    - Installed hashicorp/google v3.50.0 (signed by HashiCorp)
    - Installing hashicorp/kubernetes v2.0.2...
    - Installed hashicorp/kubernetes v2.0.2 (signed by HashiCorp)

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
```


- First Terraform will try to find the matching version as per the version provided in the [provider.tf](provider.tf). 
- Then download the providers with Matching version and keep it in **.terraform** folder. 

```
    $ tree .terraform
    .terraform   
    `-- providers
        `-- registry.terraform.io
            `-- hashicorp
                |-- aws
                |   `-- 2.70.0
                |       `-- windows_amd64
                |           `-- terraform-provider-aws_v2.70.0_x4.exe
                |-- azurerm
                |   `-- 2.50.0
                |       `-- windows_amd64
                |           `-- terraform-provider-azurerm_v2.50.0_x5.exe
                |-- google
                |   `-- 3.50.0
                |       `-- windows_amd64
                |           `-- terraform-provider-google_v3.50.0_x5.exe
                `-- kubernetes
                    `-- 2.0.2
                        `-- windows_amd64
                            `-- terraform-provider-kubernetes_v2.0.2_x5.exe

    15 directories, 4 files
```