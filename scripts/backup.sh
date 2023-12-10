#!/bin/bash

# Diretório de origem (pasta a ser copiada)
source_directory="/var/www"

# Diretório de destino (onde o backup será salvo)
backup_directory="/path/to/backup"

# Nome do arquivo de backup com carimbo de data e hora
backup_filename="backup_$(date +'%Y%m%d%H%M%S').tar.gz"

# Criar backup usando o tar
tar -czvf "$backup_directory/$backup_filename" "$source_directory"

# Verificar se o backup foi criado com sucesso
if [ $? -eq 0 ]; then
  echo "Backup criado com sucesso: $backup_directory/$backup_filename"
else
  echo "Erro ao criar o backup."
fi
