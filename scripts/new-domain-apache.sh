#!/bin/bash

# Verifica se o script está sendo executado como root
if [ "$EUID" -ne 0 ]; then
  echo "Por favor, execute como root."
  exit
fi

# Solicita o domínio ao usuário
read -p "Digite o nome do domínio que deseja adicionar: " domain

# Verifica se o domínio já existe
if [ -e "/etc/apache2/sites-available/$domain.conf" ]; then
  echo "O domínio $domain já existe. Saindo."
  exit
fi

# Cria o arquivo de configuração para o novo site
cat > "/etc/apache2/sites-available/$domain.conf" <<EOF
<VirtualHost *:80>
    ServerAdmin webmaster@$domain
    ServerName $domain
    ServerAlias www.$domain

    DocumentRoot /var/www/$domain
    <Directory /var/www/$domain>
        Options -Indexes +FollowSymLinks
        AllowOverride All
        Require all granted
    </Directory>

    ErrorLog \${APACHE_LOG_DIR}/$domain_error.log
    CustomLog \${APACHE_LOG_DIR}/$domain_access.log combined

    # Adicione aqui configurações adicionais de segurança, se necessário

</VirtualHost>
EOF

# Cria o diretório do site e adiciona o index.html
mkdir -p "/var/www/$domain"
echo "<html><body><h1>Hello, world!</h1></body></html>" > "/var/www/$domain/index.html"

# Habilita o site no Apache
a2ensite $domain

# Reinicia o Apache para aplicar as alterações
systemctl restart apache2

echo "O domínio $domain foi adicionado com sucesso."
