#!/bin/bash

# Atualizar pacotes existentes
sudo apt update
sudo apt upgrade -y

# Instalar Apache
sudo apt install apache2 -y

# Instalar MySQL
sudo apt install mysql-server -y

# Instalar PHP 8.1 e extensões comuns
sudo apt install software-properties-common -y
sudo add-apt-repository ppa:ondrej/php
sudo apt update
sudo apt install php8.1 php8.1-fpm php8.1-mysql php8.1-mbstring php8.1-xml php8.1-gd php8.1-curl php8.1-json php8.1-cli php8.1-intl php8.1-bcmath php8.1-zip -y

# Instalar phpMyAdmin
sudo apt install phpmyadmin -y

# Configurações do Apache
# Ajustar as configurações necessárias para o phpMyAdmin
echo "Include /etc/phpmyadmin/apache.conf" | sudo tee -a /etc/apache2/apache2.conf

# Alterar o proprietário e as permissões do diretório html
sudo chown -R $USER:$USER /var/www/html/
sudo chmod -R 755 /var/www/html/

# Configurar o firewall UFW
sudo ufw allow 'Apache Full'
sudo ufw allow 'OpenSSH'
sudo ufw enable

# Configuração de segurança MySQL
sudo mysql_secure_installation

# Configurações de segurança do PHP
sudo sed -i "s/display_errors = On/display_errors = Off/g" /etc/php/8.1/fpm/php.ini
sudo sed -i "s/expose_php = On/expose_php = Off/g" /etc/php/8.1/fpm/php.ini
sudo systemctl restart php8.1-fpm

# Desativar versões antigas do PHP
if sudo a2query -m php7.4 > /dev/null; then
    sudo a2dismod php7.4
fi

sudo a2enmod php8.1

sudo systemctl restart apache2

# Desativar informações de servidor Apache
sudo sed -i 's/ServerTokens OS/ServerTokens Prod/g' /etc/apache2/conf-available/security.conf
sudo sed -i 's/ServerSignature On/ServerSignature Off/g' /etc/apache2/conf-available/security.conf
sudo a2enconf security
sudo systemctl restart apache2

echo "Instalação concluída. Certifique-se de verificar as configurações adicionais necessárias para o seu aplicativo específico."
