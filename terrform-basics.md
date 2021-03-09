
# Terraform Variables

## how to Define Variables [vars.tf]

        variable "<<Variable_NAME>>" {
        type        = <<string/bool/number>>
        description = "The id of the machine image (AMI) to use for the server."
        }

exmaple:

        variable "image_id" {
        type        = string
        description = "The id of the machine image (AMI) to use for the server."
        }


### with Default value:

        variable "AWS_REGION" {
         default = "eu-west-1"
         description = "AWS Region Name."
        }

### Overriding variables.

        $terraform apply -var AWS_REGION=eu-west-2

### Overriding variables , many in that case use -var-file.

        terraform apply -var-file="testing.tfvars"


### Sensitive fields        

        variable "AWS_REGION" {
         default = "eu-west-1"
         description = "AWS Region Name."
         sensitive = true
        }

Plan output for : ami vaule will be shown as **(sensitive)**

        # aws_instance.example2 will be created
        + resource "aws_instance" "example2" {
            + ami                          = (sensitive)

### Variable Definition Precedence

If the same variable is assigned multiple values, Terraform uses the last value it finds, overriding any previous values.

Terraform loads variables in the following order, with later sources taking precedence over earlier ones:

1. Environment variables
2. The terraform.tfvars file, if present.
3. The terraform.tfvars.json file, if present.
4. Any *.auto.tfvars or *.auto.tfvars.json files, processed in lexical order of their filenames.
5. Any -var and -var-file options on the command line, in the order they are provided. 


### Configuring Terraform logging
Terraform depends on two environment variables being configured. These two variables are TF_LOG and TF_LOG_PATH, both need to be configured our no logging will occur. I will be calling my log file terraform.txt, however, it can be named whatever you like.

#### Setting in current session
If you want to temporarily configure these for your sessions here is how you do that for both PowerShell and Bash. Once these are set the next time you run the terraform command there will be a terraform.txt file in the current working directory.

#### PowerShell
        > $env:TF_LOG="TRACE"
        > $env:TF_LOG_PATH="terraform.txt"
#### Bash
        $ export TF_LOG="TRACE"
        $ export TF_LOG_PATH="terraform.txt"


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

        backend "s3" {
        bucket = "sumitgupta28-s3-backend"
        key    = "aws/terraform/aws-ec2-state-s3/terraform.tfstate"
        region = "us-east-1"
        }


![Remote State](/images/remote-state.JPG)


## terraform modules. 

Modules in Terraform allow you to reuse predefined resource structures. Using modules will decrease the snowflake effect and provide a great way to reuse existing infrastructure code.


Terraform module allows to package a application infrastrucutre resource set and parametrize them so the same resource set can be re-applied or re-used with different name/values/ami's/vpc. 

Infrastrucutre resource set can be a collection of VPC containing few private and public subnets , net & internate gateways , security groups , keys and finally few EC2 instance. 

Now if this Infrastrucutre resource set needs to be re-created for multiple regions or multiple enviroments like (DEV/STAGE/PROD) 
- You can very well do it with creating workspaces and creating multiple vars.tf files
- terraform provide another nice and cleaner approch to bundle the all the base infra into package called modules and allow the variables to be passed.

Modules have some variables as inputs, which are located in different places (eg. A different folder, or even a different repository). They define elements from a provider and can define multiple resources in themselves:

![Terraform-Module](/images/Terraform-Module.JPG)