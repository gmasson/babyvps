#!/bin/bash

# Atualizar pacotes existentes
sudo apt update
sudo apt upgrade -y

# Instalar Nginx
sudo apt install nginx -y

# Instalar MySQL
sudo apt install mysql-server -y

# Instalar PHP 8.1 e extensões comuns
sudo apt install software-properties-common -y
sudo add-apt-repository ppa:ondrej/php
sudo apt update
sudo apt install php8.1 php8.1-fpm php8.1-mysql php8.1-mbstring php8.1-xml php8.1-gd php8.1-curl php8.1-json php8.1-cli php8.1-intl php8.1-bcmath php8.1-zip -y

# Instalar phpMyAdmin
sudo apt install phpmyadmin -y

# Alterar o proprietário e as permissões do diretório html
sudo chown -R $USER:$USER /var/www/html/
sudo chmod -R 755 /var/www/html/

# Configurar o firewall UFW
read -p "Deseja ativar o UFW (firewall)? (y/n): " ufw_confirm
if [ "$ufw_confirm" = "y" ]; then
    sudo ufw allow 'Nginx Full'
    sudo ufw allow 'OpenSSH'
    sudo ufw enable
fi

# Configurar o MySQL Secure Installation
sudo mysql_secure_installation

# Configurações de segurança do PHP
sudo sed -i "s/display_errors = Off/display_errors = On/g" /etc/php/8.1/fpm/php.ini
sudo sed -i "s/expose_php = On/expose_php = Off/g" /etc/php/8.1/fpm/php.ini
sudo systemctl restart php8.1-fpm

# Reiniciar o Nginx
sudo systemctl restart nginx

echo "Instalação concluída. Certifique-se de verificar as configurações adicionais necessárias para o seu aplicativo específico."
