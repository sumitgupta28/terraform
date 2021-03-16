# How to Run 

## [Generate a key pair with name "mykey"](../generate-key-pair.md)

## [Set AWS Credentials](../provide-aws-cred-input.md) 

## Then run the plan command to see what resources its going to create
```sh
        $ terraform plan
```

## run the Apply command to create resources 
```sh
        $ terraform apply -auto-approve
```

### install sql client

these commands are added with instance startup script as well. So no need to do apply this explicitly 

       sudo yum install -y https://dev.mysql.com/get/mysql57-community-release-el7-11.noarch.rpm
       sudo yum install -y mysql-community-client

## **terraform output** to the instance public ip and rds host name 

        $ terraform output
        application-server-arn = "ARN VaLUE"
        application-server-private_ip = "XX.XX.XX.XX"
        application-server-public_ip = "XX.XX.XX.XX"
        aws_eip-nat-public_ip = "XX.XX.XX.XX"
        aws_nat_gateway-nat-gw-public_ip = "XX.XX.XX.XX"
        rds = "mariadb.XX.us-east-1.rds.amazonaws.com:3306"
        rds-password = (sensitive value)
        rds-username = "root"
## Validate Apache

        curl http://application-server-public_ip
        Hello World from ip-10-0-1-120.ec2.internal


## Validate Database

**Connect to instance**
        $ ssh -i mykey ec2-user@application-server-public_ip

**Connect to database** and give the default test password or if you have provided the password via **-var RDS_PASSWORD=** while doing apply

        $ mysql -u root -h mariadb.XX.us-east-1.rds.amazonaws.com -p
        Enter password:
        Welcome to the MySQL monitor.  Commands end with ; or \g.
        Your MySQL connection id is 20
        Server version: 5.5.5-10.4.13-MariaDB-log Source distribution

        Copyright (c) 2000, 2021, Oracle and/or its affiliates.

        Oracle is a registered trademark of Oracle Corporation and/or its
        affiliates. Other names may be trademarks of their respective
        owners.

        Type 'help;' or '\h' for help. Type '\c' to clear the current input statement.

        mysql> show databases;
        +--------------------+
        | Database           |
        +--------------------+
        | information_schema |
        | innodb             |
        | mariadb            |
        | mysql              |
        | performance_schema |
        +--------------------+
        5 rows in set (0.00 sec)
