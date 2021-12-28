#!/bin/bash
sudo apt-get update
sudo apt-get install apache2 -y
sudo apt-get install mysql-server -y
sudo mysql -e "ALTER USER 'root'@'localhost' IDENTIFIED BY 'pass@123';FLUSH PRIVILEGES;"
sudo mysql -e "DELETE FROM mysql.user WHERE User='';"
sudo mysql -e "DELETE FROM mysql.user WHERE User='root' AND Host NOT IN ('localhost', '127.0.0.1', '::1');"
sudo apt-get install php libapache2-mod-php php-mysql -y
cd /var/www/html
sudo chown ubuntu:ubuntu index.html
sudo mv index.html index.html-bak
echo "============================================"
echo "WordPress Install Script"
echo "============================================"
#echo "Database Name: "
#read -e dbname
#echo "Database User: "
#read -e dbpass
#echo "Database password"
#read -s pass
#echo "run install? (y/n)"
#read -e run
#if [ "$run" == n ] ; then
#	exit
#else
	echo "==========================="
	echo " a robot is installing worpress"
	sudo curl -O https://wordpress.org/latest.tar.gz
	sudo tar -zxvf latest.tar.gz
	cd wordpress
	sudo cp -rf . ..
	cd ..
	sudo rm -rf wordpress
	sudo cp wp-config-sample.php wp-config.php
	sudo mysql -u root -ppass@123 -e "CREATE DATABASE dbname;"
	sudo mysql -u root -ppass@123 -e "CREATE USER 'dbpass'@'localhost' IDENTIFIED BY 'pass@123';"
	sudo mysql -u root -ppass@123 -e "GRANT ALL PRIVILEGES ON dbname.* TO 'dbpass'@'localhost';"
	sudo sed -i "s/database_name_here/dbname/g" wp-config.php
	sudo sed -i "s/username_here/dbpass/g" wp-config.php
	sudo sed -i "s/password_here/pass@123/g" wp-config.php
#fi

