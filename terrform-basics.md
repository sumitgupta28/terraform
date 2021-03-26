
## Terraform Variables

### Primitive Types

A primitive type is a simple type that isn't made from any other type. All primitive types in Terraform are represented by a type keyword. The available primitive types are:

   - string: a sequence of Unicode characters representing some text, such as "hello".
   - number: a numeric value. The number type can represent both whole numbers like 15 and fractional values such as 6.283185.
   - bool: either true or false. bool values can be used in conditional logic.

### how to Define Variables [vars.tf]

```sh
        variable "<<Variable_NAME>>" {
        type        = <<string/bool/number>>
        description = "The id of the machine image (AMI) to use for the server."
        }
```

Example:

```sh
        variable "image_id" {
        type        = string
        description = "The id of the machine image (AMI) to use for the server."
        }
```

### with Default value:
```sh
        variable "AWS_REGION" {
         default = "eu-west-1"
         description = "AWS Region Name."
        }
```
### Overriding variables.
```sh
        $terraform apply -var AWS_REGION=eu-west-2
```
### Overriding variables , many in that case use -var-file.
```sh
        terraform apply -var-file="testing.tfvars"
```

### Sensitive fields        
```sh
        variable "AWS_REGION" {
         default = "eu-west-1"
         description = "AWS Region Name."
         sensitive = true
        }
```
Plan output for : ami vaule will be shown as **(sensitive)**

```sh
        # aws_instance.example2 will be created
        + resource "aws_instance" "example2" {
            + ami                          = (sensitive)
```

### Variable Definition Precedence

If the same variable is assigned multiple values, Terraform uses the last value it finds, overriding any previous values.

Terraform loads variables in the following order, with later sources taking precedence over earlier ones:

1. Environment variables
2. The terraform.tfvars file, if present.
3. The terraform.tfvars.json file, if present.
4. Any *.auto.tfvars or *.auto.tfvars.json files, processed in lexical order of their filenames.
5. Any -var and -var-file options on the command line, in the order they are provided. 


### name of a variable

The label after the variable keyword is a name for the variable, which must be unique among all variables in the same module. This name is used to assign a value to the variable from outside and to reference the variable's value from within the module.

- The variable declaration can optionally include a type argument to specify what value types are accepted for the variable, as described in the following section.

- The variable declaration can also include a default argument. If present, the variable is considered to be optional and the default value will be used if no value is set when calling the module or running Terraform. The default argument requires a literal value and cannot reference other objects in the configuration.

## Environment Variables

### Configuring Terraform logging
Terraform depends on two environment variables being configured. These two variables are TF_LOG and TF_LOG_PATH, both need to be configured our no logging will occur. I will be calling my log file terraform.txt, however, it can be named whatever you like.

You can set TF_LOG to one of the log levels TRACE, DEBUG, INFO, WARN or ERROR to change the verbosity of the logs. TRACE is the most verbose and it is the default if TF_LOG is set to something other than a log level name.

Therefore  export TF_LOG="RANDOM" or export TF_LOG="TRACE"  both can set the most verbose log level.

#### Setting in current session
If you want to temporarily configure these for your sessions here is how you do that for both PowerShell and Bash. Once these are set the next time you run the terraform command there will be a terraform.txt file in the current working directory.

#### PowerShell
```sh
        > $env:TF_LOG="TRACE"
        > $env:TF_LOG_PATH="terraform.txt"
```
#### Bash
```sh        
        $ export TF_LOG="TRACE"
        $ export TF_LOG_PATH="terraform.txt"
```

To disable, either unset it or set it to empty. When unset, logging will default to stderr. For example:

```sh
        export TF_LOG=
```

## terraform State Management 

Terraform records information about what infrastructure it created in a Terraform state file [terraform.tfstate] by default written in the project folder. 

The **terraform plan** or **terraform apply** commands, Terraform was able to find the resources it created previously and update them accordingly.

### Remote Storage of State file.

if you configure remote state , instead of storing the state file in local it will be stored in remote storage like Amazon S3, Azure Storage, Google Cloud Storage, and HashiCorp’s Terraform Pro and Terraform Enterprise.

There are many advantages of having state in remote storage. 

- **Manual error**: Once you configure a remote backend, Terraform will automatically load the state file from that backend every time you run plan or apply and it’ll automatically store the state file in that backend after each apply, so there’s no chance of manual error.

- **Locking**: Most of the remote backends natively support locking. To run terraform apply, Terraform will automatically acquire a lock; if someone else is already running apply, they will already have the lock, and you will have to wait. You can run apply with the -lock-timeout=<TIME> parameter to tell Terraform to wait up to TIME for a lock to be released (e.g., -lock-timeout=10m will wait for 10 minutes).

- **Secrets**: Most of the remote backends natively support encryption in transit and encryption on disk of the state file. S3 supports encryption at rest , authentication and authorization which protects the state file. 


### enable remote state 
```sh
        backend "s3" {
        bucket = "sumitgupta28-s3-backend"
        key    = "terraform.tfstate"
        region = "us-east-1"
        }
```

![Remote State](/images/remote-state.JPG)


## terraform modules. 

Modules in Terraform allow you to reuse predefined resource structures. Using modules will decrease the snowflake effect and provide a great way to reuse existing infrastructure code.


Terraform module allows to package a application Infrastructure resource set and parametrize them so the same resource set can be re-applied or re-used with different name/values/ami's/vpc. 

Infrastructure resource set can be a collection of VPC containing few private and public subnets , net & internet gateways , security groups , keys and finally few EC2 instance. 

Now if this Infrastructure resource set needs to be re-created for multiple regions or multiple environments like (DEV/STAGE/PROD) 
- You can very well do it with creating workspaces and creating multiple vars.tf files
- terraform provide another nice and cleaner approach to bundle the all the base infra into package called modules and allow the variables to be passed.

Modules have some variables as inputs, which are located in different places (eg. A different folder, or even a different repository). They define elements from a provider and can define multiple resources in themselves:

![Terraform-Module](/images/Terraform-Module.JPG)


## Terraform Provider Versioning

There are multiple ways to specify the provider version.

| Version                   | Possible Value                      |
| -------------             | -------------                       |
| >=1.0                     | Greater then equal to version 1.0   |
| <=1.0                     | Less then equal to version 1.0      |
| ~>2.0                     | Any Version in the 2.x range        |
| >=2.0,<=2.30              | version between 2.10 and 2.30       |


**Example Provider.tf**


```sh
        terraform {
        required_providers {
        aws = {
        source = "hashicorp/aws"
        version = "~>2.0"
        }
        azurerm = {
        source = "hashicorp/azurerm"
        version = ">=2.40"
        }

        google = {
        source = "hashicorp/google"
        version = "<=3.50"
        }

        kubernetes = {
        source = "hashicorp/kubernetes"
        version = ">=2.0,<=3.0"
        }
        }
        }
```

**init**
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
```

**.terraform.lock.hcl** file
```sh
        # This file is maintained automatically by "terraform init".
        # Manual edits may be lost in future updates.

        provider "registry.terraform.io/hashicorp/aws" {
        version     = "2.70.0"
        constraints = "~> 2.0"
        hashes = [**********]
        }

        provider "registry.terraform.io/hashicorp/azurerm" {
        version     = "2.50.0"
        constraints = ">= 2.40.0"
        hashes = [**********]
        }

        provider "registry.terraform.io/hashicorp/google" {
        version     = "3.50.0"
        constraints = "<= 3.50.0"
        hashes = [**********]
        }

        provider "registry.terraform.io/hashicorp/kubernetes" {
        version     = "2.0.2"
        constraints = ">= 2.0.0, <= 3.0.0"
        hashes = [**********]
        }
```


