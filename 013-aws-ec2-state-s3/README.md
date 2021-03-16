# How to Run 

Once you are in this directory. 

> Create a new file **terraform.tfvars** with below content 
```note
AWS_ACCESS_KEY = "<<YOUR_AWS_ACCESS_KEY>>"
AWS_SECRET_KEY = "<<YOUR_AWS_SECRET_KEY>>" 
```

Then run the plan command to see what resources its going to create

```sh
$terraform plan
```

run the Apply command to create resources 

```sh
$terraform apply -auto-approve
```