# How to Run 

Once you are in this directory. 

> Create a new file **terraform.tfvars** with below content 
```note
AWS_ACCESS_KEY = "<<YOUR_AWS_ACCESS_KEY>>"
AWS_SECRET_KEY = "<<YOUR_AWS_SECRET_KEY>>" 
```

Then run the plan command to see what resources its going to create


## Generate Key Pair

        $ ssh-keygen -f my-access-key
        Generating public/private rsa key pair.
        Enter passphrase (empty for no passphrase): 
        Enter same passphrase again: 
        Your identification has been saved in my-access-key.
        Your public key has been saved in my-access-key.pub.
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
        -rw-r--r-- 1 Sumit 197609 1675 Feb 24 10:29 my-access-key
        -rw-r--r-- 1 Sumit 197609  398 Feb 24 10:29 my-access-key.pub


```sh
$terrafrom plan
```

Run the Apply command to create resources 

```sh
$terrafrom apply -auto-approve
```

Once Complete 
- **local-exec** - 2 files will be created "private_ips.txt" & "public_ips.txt" containing the private and public  ip's 
- **remote-exec** 
    - Step 1 first login into server using the public ip and private key. 
    - Step 2 install nginx.


![Terraform-Provisioner.JPG](../images/Terraform-Provisioner.JPG)



The following arguments are supported:

```sh

      provisioner "remote-exec" {
        inline = [
        "sudo amazon-linux-extras install -y nginx1.12",
        "sudo systemctl start nginx"
        ]

        connection {
        type        = "ssh"
        user        = "ec2-user"
        private_key = file(var.PATH_TO_PRIVATE_KEY)
        host        = self.public_ip
        }
    }
    
```

- **inline** - This is a list of command strings. They are executed in the order they are provided. This cannot be provided with script or scripts.

- **script** - This is a path (relative or absolute) to a local script that will be copied to the remote resource and then executed. This cannot be provided with inline or scripts.

- **scripts** - This is a list of paths (relative or absolute) to local scripts that will be copied to the remote resource and then executed. They are executed in the order they are provided. This cannot be provided with inline or script.

### [how to use scripts](https://www.terraform.io/docs/language/resources/provisioners/remote-exec.html#script-arguments)

You cannot pass any arguments to scripts using the script or scripts arguments to this provisioner. If you want to specify arguments, upload the script with the file provisioner and then use inline to call it. Example:

```sh

        resource "aws_instance" "web" {
        # ...

        provisioner "file" {
            source      = "script.sh"
            destination = "/tmp/script.sh"
        }

        provisioner "remote-exec" {
            inline = [
            "chmod +x /tmp/script.sh",
            "/tmp/script.sh args",
            ]
        }
        }
```