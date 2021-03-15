# Generate Key Pair

```sh
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
```
List the created key pair 

```sh
        $ ls -lrt
        total 2
        -rw-r--r-- 1 Sumit 197609 1675 Feb 24 10:29 mykey
        -rw-r--r-- 1 Sumit 197609  398 Feb 24 10:29 mykey.pub
```