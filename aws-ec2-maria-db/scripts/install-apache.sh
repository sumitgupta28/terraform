  #!/bin/bash	
	########################################
	##### USE THIS WITH AMAZON LINUX 2 #####
	########################################
	# get admin privileges
	sudo su
    sudo apt update

	# install Apache
    sudo apt-get install apache2 -y
    echo "Hello World from $(hostname -f)" > /var/www/html/index.html
    
	# install my-sql-client
	sudo apt-get -y install mysql-client