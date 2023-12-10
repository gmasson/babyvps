melhore esse código focando em segurança

#!/bin/bash

# Verifica se o script está sendo executado como root
if [ "$EUID" -ne 0 ]; then
  echo "Por favor, execute como root."
  exit
fi

# Solicita o domínio ao usuário
read -p "Digite o nome do domínio que deseja adicionar: " domain

# Verifica se o domínio já existe
if [ -e "/etc/nginx/sites-available/$domain" ]; then
  echo "O domínio $domain já existe. Saindo."
  exit
fi

# Cria o arquivo de configuração para o novo site
cat > "/etc/nginx/sites-available/$domain" <<EOF
server {
    listen 80;
    server_name $domain www.$domain;

    root /var/www/$domain;
    index index.html;

    location / {
        try_files \$uri \$uri/ =404;
    }

    location ~ \.php$ {
        include snippets/fastcgi-php.conf;
        fastcgi_pass unix:/var/run/php/php8.1-fpm.sock;
        fastcgi_param SCRIPT_FILENAME \$document_root\$fastcgi_script_name;
        include fastcgi_params;
    }

    access_log /var/log/nginx/$domain.access.log;
    error_log /var/log/nginx/$domain.error.log;
}

EOF

# Cria o diretório do site e adiciona o index.html
mkdir -p "/var/www/$domain"
echo "<html><body><h1>Hello, world!</h1></body></html>" > "/var/www/$domain/index.html"

# Cria o link simbólico para sites-enabled
ln -s "/etc/nginx/sites-available/$domain" "/etc/nginx/sites-enabled/"

# Testa a configuração do Nginx
nginx -t

# Reinicia o Nginx para aplicar as alterações
systemctl restart nginx

echo "O domínio $domain foi adicionado com sucesso."