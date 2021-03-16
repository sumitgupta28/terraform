# How to Run 

Once you are in this directory. 

> Create a new file **terraform.tfvars** with below content 
```note
AWS_ACCESS_KEY = "<<YOUR_AWS_ACCESS_KEY>>"
AWS_SECRET_KEY = "<<YOUR_AWS_SECRET_KEY>>" 
```

> ensure to create a bucket to store the **terraform.tfstate** file

```sh
    $ aws s3 mb s3://sumitgupta28-s3-backend
    make_bucket: sumitgupta28-s3-backend
```

> Then run the plan command to see what resources its going to create

```sh
    $terraform plan
```

> run the Apply command to create resources 

```sh
    $terraform apply -auto-approve
```

> ensure the tfstate file is stored in s3 bucket

```
    $ aws s3 ls s3://sumitgupta28-s3-backend
    2021-03-13 21:40:41       7304 terraform.tfstate
```

> Now lets exlore the commands associated with [Terraform states](../terraform-commands.md) 


### How to rename a resource instead of deleting it?

Renaming a resource in Terraform without deleting and creating it is a 2 step process.

For example, to rename the aws_instance resource named test to tool_instance:

1.  Define your resource block with a new name.

```
resource "aws_instance" "tool_instance" {
  ami           = "ami-05794d4ef61b053f2"
  instance_type = "t2.micro"
}

```

2.  Use the Terraform move command.

```
    # Execute the Terraform move command 
    # by passing your old resource name first, followed by your new resource name.

    $ terraform state mv 'aws_instance.test_instance' 'aws_instance.test_instance-1'
    Move "aws_instance.test_instance" to "aws_instance.test_instance-1"
    Successfully moved 1 object(s).
```

3. verify it
run, Terraform plan command after above given two steps, and make sure terraform plan says - "No changes. Infrastructure is up-to-date." same as example given below -

```
    $ terraform plan
    aws_instance.test_instance-1: Refreshing state... [id=i-0d0738eddc3c6f759]

    No changes. Infrastructure is up-to-date.

    This means that Terraform did not detect any differences between your
    configuration and real physical resources that exist. As a result, no
    actions need to be performed.
```