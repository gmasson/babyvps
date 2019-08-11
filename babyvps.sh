#!/bin/bash

sudo apt-get update
sudo apt-get upgrade

# APACHE 2
echo ""
echo "Do you want to install APACHE 2? (y/n)"
read -p "= " confim;
if [[ $confim == "y" ]]; then
	echo " -------------- APACHE 2 --------------"
	sudo apt-get install apache2 apache2-utils
fi

# NGINX
echo ""
echo "Do you want to install NGINX? (y/n)"
read -p "= " confim;
if [[ $confim == "y" ]]; then
	echo " -------------- NGINX --------------"
	sudo apt-get install nginx
fi

# MYSQL
echo ""
echo "Do you want to install MYSQL? (y/n)"
read -p "= " confim;
if [[ $confim == "y" ]]; then
	echo " -------------- MYSQL --------------"
	sudo apt-get install mysql-server php5-mysql
	sudo mysql_install_db
	sudo mysql_secure_installation
fi

# MariaDB
echo ""
echo "Do you want to install MariaDB? (y/n)"
read -p "= " confim;
if [[ $confim == "y" ]]; then
	echo " -------------- Instalando --------------"
	sudo apt-get install mariadb-server mariadb-client
fi

# PHP 7
echo ""
echo "Do you want to install PHP 7? (y/n)"
read -p "= " confim;
if [[ $confim == "y" ]]; then
	echo " -------------- PHP 7 --------------"
	sudo apt-get install php7.0-fpm php7.0-mysql php7.0-common php7.0-gd php7.0-json php7.0-cli php7.0-curl libapache2-mod-php7.0
fi

# NODEJS
echo ""
echo "Do you want to install NODEJS? (y/n)"
read -p "= " confim;
if [[ $confim == "y" ]]; then
	echo " -------------- NODEJS --------------"
	sudo apt-get install nodejs
fi

# NPM
echo ""
echo "Do you want to install NPM? (y/n)"
read -p "= " confim;
if [[ $confim == "y" ]]; then
	echo " -------------- NPM --------------"
	sudo apt-get install npm
fi

# NANO
echo ""
echo "Do you want to install NANO? (y/n)"
read -p "= " confim;
if [[ $confim == "y" ]]; then
	echo " -------------- NANO --------------"
	sudo apt-get install nano
fi

# PROFTP
echo ""
echo "Do you want to install PROFTP? (y/n)"
read -p "= " confim;
if [[ $confim == "y" ]]; then
	echo " -------------- PROFTP --------------"
	sudo apt-get install proftpd 
fi
