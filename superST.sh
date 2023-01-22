#!/bin/zsh

#Super target version 1.0. Sera una mejora al script de savitar que nos creara un 3 archivos que despues podremos en la barra de informacion de gnome par que nos indique iplocal, target y vpn

echo "
 __      __        .__   __   .__ 
/  \    /  \_____  |  | |  | _|__|
\   \/\/   /\__  \ |  | |  |/ /  |
 \        /  / __ \|  |_|    <|  |
  \__/\  /  (____  /____/__|_ \__|
       \/        \/          \/   

"
# Obtener la dirección IP local
local_ip=$(ipconfig getifaddr en0)

# Obtener la dirección IP de ping
ping_ip=$(ping -c 1 google.com | awk 'NR==1 {print $3}' | sed 's/(//' | sed 's/)//')

# Obtener la dirección IP de la conexión VPN
vpn_ip=$(ifconfig vpn0 | grep "inet " | awk '{print $2}')

# Crear la carpeta 'workfield' si no existe
if [ ! -d "workfield" ]; then
  mkdir ~/workfield
fi

# Comprobar si hay archivos en la carpeta 'workfield'
if [ "$(ls -A workfield)" ]; then
  read -p "¿Su campo de juego a cambiara desea hacerlo? (s/n) " -n 1 -r
  echo
  if [[ $REPLY =~ ^[Ss]$ ]]; then
    rm -rf workfield/*
  else
    exit
  fi
fi

# Crear el archivo '.nfo' con la información obtenida
echo "Local IP: $local_ip" >> ~/workfield/local.nfo
echo "Ping IP: $ping_ip" >> ~/workfield/target.nfo
echo "VPN IP: $vpn_ip" >> ~/workfield/htb.nfo
