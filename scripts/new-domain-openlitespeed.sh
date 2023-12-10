#!/bin/bash

# Verifica se o script está sendo executado como root
if [ "$EUID" -ne 0 ]; then
  echo "Por favor, execute como root."
  exit
fi

# Solicita o domínio ao usuário
read -p "Digite o nome do domínio que deseja adicionar: " domain

# Verifica se o domínio já existe
if [ -e "/usr/local/lsws/conf/vhosts/$domain" ]; then
  echo "O domínio $domain já existe. Saindo."
  exit
fi

# Cria o arquivo de configuração para o novo site
cat > "/usr/local/lsws/conf/vhosts/$domain" <<EOF
docRoot                   \$VH_ROOT/htdocs/
vhDomain                  $domain
configFile                conf/\$VH_NAME/vhconf.conf
enableGzip                1
enableIpGeo               1

errorlog \$SERVER_ROOT/logs/\$VH_NAME_error.log {
  useServer               0
  logLevel                ERROR
}

accesslog \$SERVER_ROOT/logs/\$VH_NAME_access.log {
  useServer               0
  logFormat               "%h %l %u %t \"%r\" %>s %b \"%{Referer}i\" \"%{User-Agent}i\""
}

index  {
  useServer               0
  indexFiles              index.html
}

scripthandler  {
  add                     lsapi:wsgi  php
  add                     external-app:fcgi  php

  lsapi  {
    extAppSetUIDMode      0
    autoStart             1
    path                  fcgi-bin/lsphp8.0
  }
}
EOF

# Cria o diretório do site e adiciona o index.html
mkdir -p "/var/www/$domain"
echo "<html><body><h1>Hello, world!</h1></body></html>" > "/var/www/$domain/index.html"

# Reinicia o OpenLiteSpeed para aplicar as alterações
systemctl restart lsws

echo "O domínio $domain foi adicionado com sucesso."
