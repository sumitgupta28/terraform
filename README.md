# [Terraform](https://www.terraform.io/intro/index.html)


## What is Terraform

Terraform is an open source “Infrastructure as Code” tool, created by HashiCorp.

A declarative coding tool, Terraform enables developers to use a high-level configuration language called HCL (HashiCorp Configuration Language) to describe the desired “end-state” cloud or on-premises infrastructure for running an application. It then generates a plan for reaching that end-state and executes the plan to provision the infrastructure.

Terraform is a tool to build out server infrastructure through code, sometimes called Infrastructure as Code. This allows you to define your entire infrastructure with code for repeatable and consistent builds. Terraform can be used to deploy vm's, storage, networking, DNS, load Balancers and more with cloud infrastructure providers like AWS and Azure among others.

Cloud providers like AWS and Azure have their own way to define infrastructure as code with CloudFormation and Azure Resource Manager (ARM) templates. Terraform takes this a step further and can manage multiple cloud providers in one configuration.

Terraform uses its own configuration language called "Terraform Language" which is based off of HCL.

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

![vs. Ansible](images/terraform-life-cycle.JPG)


## How to Run the examples

Provide **AWS_ACCESS_KEY** and **AWS_SECRET_KEY** as input to terraform

![how-to-run](images/how-to-run.JPG)

### Method#1 using terraform.tfvars
> Create a new file **terraform.tfvars** with below content inside the project folder

```sh
    AWS_ACCESS_KEY = "<<YOUR_AWS_ACCESS_KEY>>"
    AWS_SECRET_KEY = "<<AWS_SECRET_KEY>>" 
```

### Method#2 using env variables.

```sh
export AWS_ACCESS_KEY="<<YOUR_AWS_ACCESS_KEY>>"
export AWS_SECRET_KEY="<<AWS_SECRET_KEY>>"
```

### Method#3 input as var to terraform commands

```sh
terraform plan -var AWS_ACCESS_KEY="<<YOUR_AWS_ACCESS_KEY>>" -var AWS_SECRET_KEY="<<AWS_SECRET_KEY>>"
terraform apply -var AWS_ACCESS_KEY="<<YOUR_AWS_ACCESS_KEY>>" -var AWS_SECRET_KEY="<<AWS_SECRET_KEY>>"
```

### Method#4 use the aws cli configuration. 

- step 1, remove AWS_ACCESS_KEY/AWS_SECRET_KEY ref from **vars.tf** and **provider.tf**
- step 2, perfrom aws cli configuration.


### Troubleshoot tips
If you see below error it means you need to create a new set of key pair and AWS might have invalidate it because of various reasons.

```
    Error: error configuring Terraform AWS Provider: error validating provider credentials: error calling sts:GetCallerIdentity: InvalidClientTokenId: The security token included in the request is invalid.
            status code: 403,
```

-  [Terraform Basics](./terrform-basics.md)

-  [Terraform Commands](./terraform-commands.md)

-  [Terraform AWS Demo](./aws-terraform-example.md)

## Examples 

- [01-provider-version-test](./01-provider-version-test/README.md)
- [02-variables](./02-variables/README.md)
- [03-datasource](./03-datasource/README.md)
- [04-provisioner](./04-provisioner/README.md)
- [05-modules](./05-modules/README.md)
- [06-terraform-state](./06-terraform-state/README.md)
- [07-terraform-state-import](./07-terraform-state-import/README.md)
- [08-terraform-multi-region-provider](./08-terraform-multi-region-provider/README.md)
- [09-terraform-cloud-demo](./09-terraform-cloud-demo/README.md)
- [010-github-demo](./010-github-demo/README.md)
- [011-aws-create-s3](./011-aws-create-s3/README.md)
- [012-aws-ec2](./012-aws-ec2/README.md)
- [013-aws-ec2-state-s3](./013-aws-ec2-state-s3/README.md)
- [014-aws-ec2-workspace](./014-aws-ec2-workspace/README.md)
- [015-aws-ec2-maria-db](./015-aws-ec2-maria-db/README.md)
- [016-aws-install-jenkins](./016-aws-install-jenkins/README.md)
- [017-aws-online-portal](./017-aws-online-portal/README.md)
- [018-aws-modules](./018-aws-modules/README.md)

