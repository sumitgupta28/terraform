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
    $terrafrom plan
```

> run the Apply command to create resources 

```sh
    $terrafrom apply -auto-approve
```

> ensure the tfstate file is stored in s3 bucket

```
    $ aws s3 ls s3://sumitgupta28-s3-backend
    2021-03-13 21:40:41       7304 terraform.tfstate
```

> Now lets exlore the commands associated with [Terraform states](../terraform-commands.md) 


