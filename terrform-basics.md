
## Terraform Variables

### how to Define Variables [vars.tf]

        variable "<<Variable_NAME>>" {
        type        = <<string/bool/number>>
        description = "The id of the machine image (AMI) to use for the server."
        }

exmaple:

        variable "image_id" {
        type        = string
        description = "The id of the machine image (AMI) to use for the server."
        }


#### with Default value:

        variable "AWS_REGION" {
         default = "eu-west-1"
         description = "AWS Region Name."
        }

#### Overriding variables.

        $terraform apply -var AWS_REGION=eu-west-2

#### Overriding variables , many in that case use -var-file.

        terraform apply -var-file="testing.tfvars"


#### Sensitive fields        

        variable "AWS_REGION" {
         default = "eu-west-1"
         description = "AWS Region Name."
         sensitive = true
        }

Plan output for : ami vaule will be shown as **(sensitive)**

        # aws_instance.example2 will be created
        + resource "aws_instance" "example2" {
            + ami                          = (sensitive)

#### Variable Definition Precedence

If the same variable is assigned multiple values, Terraform uses the last value it finds, overriding any previous values.

Terraform loads variables in the following order, with later sources taking precedence over earlier ones:

1. Environment variables
2. The terraform.tfvars file, if present.
3. The terraform.tfvars.json file, if present.
4. Any *.auto.tfvars or *.auto.tfvars.json files, processed in lexical order of their filenames.
5. Any -var and -var-file options on the command line, in the order they are provided. 


#### Configuring Terraform logging
Terraform depends on two environment variables being configured. These two variables are TF_LOG and TF_LOG_PATH, both need to be configured our no logging will occur. I will be calling my log file terraform.txt, however, it can be named whatever you like.

#### Setting in current session
If you want to temporarily configure these for your sessions here is how you do that for both PowerShell and Bash. Once these are set the next time you run the terraform command there will be a terraform.txt file in the current working directory.

#### PowerShell
        > $env:TF_LOG="TRACE"
        > $env:TF_LOG_PATH="terraform.txt"
#### Bash
        $ export TF_LOG="TRACE"
        $ export TF_LOG_PATH="terraform.txt"