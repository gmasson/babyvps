# BabyVPS
Pack de scripts para instalação de programas, uso de utilitários e configurações em servidores Ubuntu.

## Scripts

`install-apache.sh`: Instala Apache 2, PHP 8.1, MySQL, PHPMyAdmin, e realiza configurações de segurança.

`install-nginx.sh`: Instala Nginx, PHP 8.1, MySQL, PHPMyAdmin, e realiza configurações de segurança.

`install-openlitespeed.sh`: Instala OpenLiteSpeed, PHP 8.1, MySQL, PHPMyAdmin, e realiza configurações de segurança.

`new-domain-apache.sh`: Cria o diretório e configura o Apache para um novo domínio.

`new-domain-nginx.sh`: Cria o diretório e configura o Nginx para um novo domínio.

`new-domain-openlitespeed.sh`: Cria o diretório e configura o OpenLiteSpeed para um novo domínio.

`backup.sh`: Realiza o backup de /var/www/ em arquivo .tar.gz para uma pasta pré determinada.

`update.sh`: Realiza a atualização de todo servidor.


## Instalação

Clone o repositório em sua VPS usando o comando:

    git clone https://github.com/gmasson/babyvps.git

Altere as permissões e abra a pasta com o comando:

    chmod -R 750 babyvps && cd ./babyvps

Na etapa final, escolha um script da pasta /scripts e execute-o na linha de comando, por exemplo:

    ./scripts/install-nginx.sh

Todos os scripts terão seus programas e configurações pré definidas. É importante que você revise o código para verificar se os padrões são os mesmos que deseja.