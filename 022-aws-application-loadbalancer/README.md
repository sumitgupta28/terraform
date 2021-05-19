# How to Run 

## [Generate a key pair with name "mykey"](../generate-key-pair.md)

## [Set AWS Credentials](../provide-aws-cred-input.md) 

In this exmaple we are going to create below infrastructure.

1. Create a VPC
2. Create 2 public subnet
3. Create EC2 instance in both the subnet. 
4. Install Apache in both instance 
5. Create Application Load Balancer 
6. Create target group.
7. Add Instance to target group.
8. Attache target group with Application Load Balancer.




## Then run the plan command to see what resources its going to create
```sh
    $ terraform plan


```

## run the Apply command to create resources 
```sh
    $ terraform apply -auto-approve
    aws_key_pair.application-keypair: Creating...
    aws_vpc.sgsys-application-vpc: Creating...   
    aws_key_pair.application-keypair: Creation complete after 1s [id=mykeypair]
    aws_vpc.sgsys-application-vpc: Still creating... [10s elapsed]
    aws_vpc.sgsys-application-vpc: Creation complete after 15s [id=vpc-0bc85363ea019bb3c]
    aws_internet_gateway.sgsys-application-internate-gateway: Creating...
    aws_security_group.allow-ssh: Creating...
    aws_subnet.application-pub-subnet-us-east-1a: Creating...
    aws_subnet.application-pub-subnet-us-east-1b: Creating...
    aws_internet_gateway.sgsys-application-internate-gateway: Creation complete after 2s [id=igw-01f7660d19cde8679]
    aws_route_table.application-public-route-table: Creating...
    aws_security_group.allow-ssh: Creation complete after 4s [id=sg-0a33bac5b9cd9db63]
    aws_route_table.application-public-route-table: Creation complete after 2s [id=rtb-0ccdd9d73206aebdf]
    aws_subnet.application-pub-subnet-us-east-1a: Still creating... [10s elapsed]
    aws_subnet.application-pub-subnet-us-east-1b: Still creating... [10s elapsed]
    aws_subnet.application-pub-subnet-us-east-1b: Creation complete after 13s [id=subnet-0401056020209949a]
    aws_subnet.application-pub-subnet-us-east-1a: Creation complete after 13s [id=subnet-0faf2aefc6fce3f10]
    aws_route_table_association.application-rt-assoc-pub-subnet-1: Creating...
    aws_lb.alb: Creating...
    aws_instance.application-pub-subnet-us-east-1b: Creating...
    aws_route_table_association.application-rt-assoc-pub-subnet-2: Creating...
    aws_instance.application-server-us-east-1a: Creating...
    aws_route_table_association.application-rt-assoc-pub-subnet-1: Creation complete after 1s [id=rtbassoc-0dd57af7a9b5198e2]
    aws_route_table_association.application-rt-assoc-pub-subnet-2: Creation complete after 1s [id=rtbassoc-0bf56da818f9eb1a2]
    aws_instance.application-pub-subnet-us-east-1b: Still creating... [10s elapsed]
    aws_lb.alb: Still creating... [10s elapsed]
    aws_instance.application-server-us-east-1a: Still creating... [10s elapsed]
    aws_instance.application-pub-subnet-us-east-1b: Still creating... [20s elapsed]
    aws_lb.alb: Still creating... [20s elapsed]
    aws_instance.application-server-us-east-1a: Still creating... [20s elapsed]
    aws_instance.application-pub-subnet-us-east-1b: Still creating... [30s elapsed]
    aws_lb.alb: Still creating... [30s elapsed]
    aws_instance.application-server-us-east-1a: Still creating... [30s elapsed]
    aws_instance.application-pub-subnet-us-east-1b: Creation complete after 36s [id=i-098e5862007b333d2]
    aws_instance.application-server-us-east-1a: Creation complete after 36s [id=i-0415a9b6f4bd54277]
    aws_lb.alb: Still creating... [40s elapsed]
    aws_lb.alb: Still creating... [50s elapsed]
    aws_lb.alb: Still creating... [1m0s elapsed]
    aws_lb.alb: Still creating... [1m10s elapsed]
    aws_lb.alb: Still creating... [1m20s elapsed]
    aws_lb.alb: Still creating... [1m30s elapsed]
    aws_lb.alb: Still creating... [1m40s elapsed]
    aws_lb.alb: Still creating... [1m50s elapsed]
    aws_lb.alb: Still creating... [2m0s elapsed]
    aws_lb.alb: Creation complete after 2m6s [id=arn:aws:elasticloadbalancing:us-east-1:119956859268:loadbalancer/app/terraform-example-alb/9dba0abef643c341]
    aws_alb_target_group.group: Creating...
    aws_alb_target_group.group: Creation complete after 1s [id=arn:aws:elasticloadbalancing:us-east-1:119956859268:targetgroup/terraform-example-alb-target/55e8aa0f6e34442e]
    aws_lb_target_group_attachment.aws_lb_target_group_attachment-application-server-us-east-1a: Creating...
    aws_lb_target_group_attachment.aws_lb_target_group_attachment-application-pub-subnet-us-east-1b: Creating...
    aws_alb_listener.listener_http: Creating...
    aws_lb_target_group_attachment.aws_lb_target_group_attachment-application-server-us-east-1a: Creation complete after 0s [id=arn:aws:elasticloadbalancing:us-east-1:119956859268:targetgroup/terraform-example-alb-target/55e8aa0f6e34442e-20210519060125484200000001]
    aws_lb_target_group_attachment.aws_lb_target_group_attachment-application-pub-subnet-us-east-1b: Creation complete after 0s [id=arn:aws:elasticloadbalancing:us-east-1:119956859268:targetgroup/terraform-example-alb-target/55e8aa0f6e34442e-20210519060125488200000002]
    aws_alb_listener.listener_http: Creation complete after 1s [id=arn:aws:elasticloadbalancing:us-east-1:119956859268:listener/app/terraform-example-alb/9dba0abef643c341/5d016dcb3d3e36a7]

    Apply complete! Resources: 16 added, 0 changed, 0 destroyed.

    Outputs:

    application-pub-subnet-us-east-1b-public_ip = "54.161.192.250"
    application-server-us-east-1a-public_ip = "18.215.15.32"
    aws_lb-url = "terraform-example-alb-16612166.us-east-1.elb.amazonaws.com"

```
Try to access application via url in output

# Clean up - terraform destroy

```sh
    $ terraform destroy -auto-approve
    aws_alb_listener.listener_http: Destroying... [id=arn:aws:elasticloadbalancing:us-east-1:119956859268:listener/app/terraform-example-alb/9dba0abef643c341/5d016dcb3d3e36a7]
    aws_route_table_association.application-rt-assoc-pub-subnet-1: Destroying... [id=rtbassoc-0dd57af7a9b5198e2]
    aws_lb_target_group_attachment.aws_lb_target_group_attachment-application-server-us-east-1a: Destroying... [id=arn:aws:elasticloadbalancing:us-east-1:119956859268:targetgroup/terraform-example-alb-target/55e8aa0f6e34442e-20210519060125484200000001]
    aws_route_table_association.application-rt-assoc-pub-subnet-2: Destroying... [id=rtbassoc-0bf56da818f9eb1a2]
    aws_lb_target_group_attachment.aws_lb_target_group_attachment-application-pub-subnet-us-east-1b: Destroying... [id=arn:aws:elasticloadbalancing:us-east-1:119956859268:targetgroup/terraform-example-alb-target/55e8aa0f6e34442e-20210519060125488200000002]
    aws_route_table_association.application-rt-assoc-pub-subnet-2: Destruction complete after 1s
    aws_route_table_association.application-rt-assoc-pub-subnet-1: Destruction complete after 1s
    aws_lb_target_group_attachment.aws_lb_target_group_attachment-application-pub-subnet-us-east-1b: Destruction complete after 1s
    aws_lb_target_group_attachment.aws_lb_target_group_attachment-application-server-us-east-1a: Destruction complete after 1s
    aws_route_table.application-public-route-table: Destroying... [id=rtb-0ccdd9d73206aebdf]
    aws_instance.application-server-us-east-1a: Destroying... [id=i-0415a9b6f4bd54277]
    aws_instance.application-pub-subnet-us-east-1b: Destroying... [id=i-098e5862007b333d2]
    aws_alb_listener.listener_http: Destruction complete after 1s
    aws_alb_target_group.group: Destroying... [id=arn:aws:elasticloadbalancing:us-east-1:119956859268:targetgroup/terraform-example-alb-target/55e8aa0f6e34442e]
    aws_alb_target_group.group: Destruction complete after 0s
    aws_lb.alb: Destroying... [id=arn:aws:elasticloadbalancing:us-east-1:119956859268:loadbalancer/app/terraform-example-alb/9dba0abef643c341]
    aws_route_table.application-public-route-table: Destruction complete after 1s
    aws_internet_gateway.sgsys-application-internate-gateway: Destroying... [id=igw-01f7660d19cde8679]
    aws_lb.alb: Destruction complete after 2s
    aws_instance.application-pub-subnet-us-east-1b: Still destroying... [id=i-098e5862007b333d2, 10s elapsed]
    aws_instance.application-server-us-east-1a: Still destroying... [id=i-0415a9b6f4bd54277, 10s elapsed]
    aws_internet_gateway.sgsys-application-internate-gateway: Still destroying... [id=igw-01f7660d19cde8679, 10s elapsed]
    aws_instance.application-pub-subnet-us-east-1b: Still destroying... [id=i-098e5862007b333d2, 20s elapsed]
    aws_instance.application-server-us-east-1a: Still destroying... [id=i-0415a9b6f4bd54277, 20s elapsed]
    aws_internet_gateway.sgsys-application-internate-gateway: Still destroying... [id=igw-01f7660d19cde8679, 20s elapsed]
    aws_internet_gateway.sgsys-application-internate-gateway: Destruction complete after 28s
    aws_instance.application-server-us-east-1a: Still destroying... [id=i-0415a9b6f4bd54277, 30s elapsed]
    aws_instance.application-pub-subnet-us-east-1b: Still destroying... [id=i-098e5862007b333d2, 30s elapsed]
    aws_instance.application-pub-subnet-us-east-1b: Still destroying... [id=i-098e5862007b333d2, 40s elapsed]
    aws_instance.application-server-us-east-1a: Still destroying... [id=i-0415a9b6f4bd54277, 40s elapsed]
    aws_instance.application-pub-subnet-us-east-1b: Destruction complete after 41s
    aws_subnet.application-pub-subnet-us-east-1b: Destroying... [id=subnet-0401056020209949a]
    aws_instance.application-server-us-east-1a: Destruction complete after 41s
    aws_subnet.application-pub-subnet-us-east-1a: Destroying... [id=subnet-0faf2aefc6fce3f10]
    aws_key_pair.application-keypair: Destroying... [id=mykeypair]
    aws_security_group.allow-ssh: Destroying... [id=sg-0a33bac5b9cd9db63]
    aws_key_pair.application-keypair: Destruction complete after 1s
    aws_subnet.application-pub-subnet-us-east-1a: Destruction complete after 1s
    aws_subnet.application-pub-subnet-us-east-1b: Destruction complete after 1s
    aws_security_group.allow-ssh: Destruction complete after 1s
    aws_vpc.sgsys-application-vpc: Destroying... [id=vpc-0bc85363ea019bb3c]
    aws_vpc.sgsys-application-vpc: Destruction complete after 1s

    Destroy complete! Resources: 16 destroyed.


```
