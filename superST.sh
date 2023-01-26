#!/bin/bash

#Super target version 1.0. Sera una mejora al script de savitar que nos creara un 3 archivos que despues podremos en la barra de informacion de gnome par que nos indique iplocal, target y vpn

echo "
 __      __        .__   __   .__ 
/  \    /  \_____  |  | |  | _|__|
\   \/\/   /\__  \ |  | |  |/ /  |
 \        /  / __ \|  |_|    <|  |
  \__/\  /  (____  /____/__|_ \__|
       \/        \/          \/   

"

# Investigar los nombres de los adaptadores de red y de Wi-Fi
network_adapters=($(ip link | grep -E "^[0-9]+: (enp|wlan)" -o | sed 's/: //'))

# Mostrar los adaptadores de red y Wi-Fi
echo "Adaptadores disponibles:"
for adapter in "${network_adapters[@]}"; do
    echo "    $adapter"
done

# Preguntar al usuario cual adaptador desea utilizar
read -i "Seleccione el adaptador de red que desea utilizar: " $network_adapters

# Obtener la dirección IP del adaptador seleccionado
local_ip=$(ip -4 addr show $network_adapters | grep -oP '(?<=inet\s)\d+(\.\d+){3}')


