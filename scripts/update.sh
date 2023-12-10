#!/bin/bash

# Atualiza os pacotes do sistema
sudo apt update
sudo apt upgrade -y

# Remove pacotes desnecessários
sudo apt autoremove -y

# Limpa o cache dos pacotes
sudo apt clean

# Reinicia o servidor
sudo reboot