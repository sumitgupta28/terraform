## Generate Key Pair

        $ ssh-keygen -f mykey
        Generating public/private rsa key pair.
        Enter passphrase (empty for no passphrase): 
        Enter same passphrase again: 
        Your identification has been saved in mykey.
        Your public key has been saved in mykey.pub.
        The key fingerprint is:
        SHA256:7JlA8t+tBn1yb2KDFeF0VoDoNuvoU/hW7YwX1NGgmBI Sumit@sumitgupta
        The key's randomart image is:
        +---[RSA 2048]----+
        |        E  . .o+o|
        |         ..o+.o..|
        |    . . ..oo.+ ..|
        |     + . .+ o . .|
        |      o S+ o +   |
        |       +o+=.= o  |
        |        =*.B.= . |
        |        o *.= *  |
        |       ..+.. =   |
        +----[SHA256]-----+


        $ ls -lrt
        total 2
        -rw-r--r-- 1 Sumit 197609 1675 Feb 24 10:29 mykey
        -rw-r--r-- 1 Sumit 197609  398 Feb 24 10:29 mykey.pub


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
