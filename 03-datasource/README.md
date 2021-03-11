
# [terraform data-sources](https://www.terraform.io/docs/language/data-sources/index.html)

Data sources allow data to be fetched or computed for use elsewhere in Terraform configuration. Use of data sources allows a Terraform configuration to make use of information defined outside of Terraform, or defined by another separate Terraform configuration.

Each provider may offer data sources alongside its set of resource types.

Data block:

```sh
    data "aws_ami" "free-tier" {
    most_recent = true
    owners = [ "amazon" ] #137112412989
    filter {
        name   = "name"
        values = ["amzn2-ami-hvm-2.0.20210303.0-x86_64-gp2"]
    }

    filter {
        name   = "virtualization-type"
        values = ["hvm"]
    }
    }
```

on execution this datablock will look for ami's owned by "amazon" , name as "amzn2-ami-hvm-2.0.20210303.0-x86_64-gp2" and virtualization-type as "hvm".

Later the "aws_ami.free-tier" can used in instance creation. 

```sh
resource "aws_instance" "front-end" {
  ami           = data.aws_ami.free-tier.id
  instance_type = var.INSTANCE_TYPE
}
```


# How to Run 

Once you are in this directory. 

> Create a new file **terraform.tfvars** with below content 
```note
AWS_ACCESS_KEY = "<<YOUR_AWS_ACCESS_KEY>>"
AWS_SECRET_KEY = "<<YOUR_AWS_SECRET_KEY>>" 
```

Then run the plan command and grep the ami value

for AWS_REGION=us-west-1

```sh
    $ terraform plan -var 'AWS_REGION=us-west-1' | grep ami
          + ami                          = "ami-0c7945b4c95c0481c"
```

for AWS_REGION=us-east-2
```
    $ terraform plan -var 'AWS_REGION=us-east-2' | grep ami
      + ami                          = "ami-07a0844029df33d7d"
```      

for AWS_REGION=us-west-2

```
    $ terraform plan -var 'AWS_REGION=us-west-2' | grep ami
      + ami                          = "ami-00f9f4069d04c0c6e"
```

for AWS_REGION=us-east-1

```
$ terraform plan -var 'AWS_REGION=us-east-1' | grep ami
      + ami                          = "ami-038f1ca1bd58a5790"
```