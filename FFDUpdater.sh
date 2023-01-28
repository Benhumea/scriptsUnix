#!/bin/bash

#Firefox download UPdater version 1.0.0

# Asignar la carpeta de descargas a una variable
descarga_folder="/home/walky/Descargas"

if pgrep -x "firefox-bin"; then
        echo "Firefox esta en uso, por favor cierrelo para actualizar."
        exit 1
    fi

# Buscar archivos que comienzan con "firefox" y terminan en ".bz2" en la carpeta de descargas
archivo=$(find $descarga_folder -name "firefox*bz2")

# Si se encuentra un archivo
if [ -n "$archivo" ]; then
    echo "Se encontró el archivo $archivo en la carpeta de descargas"
else
    echo "No se encontró ningún archivo que comience con 'firefox' y termine en '.bz2' en la carpeta de descargas"
    read -p "Ingresa la dirección de la descarga:" url
    eval "wget --output-document=firefox.tar.bz2 $url"
fi



