#!/bin/bash

# Definir las rutas de los directorios a respaldar
DIRS=(
    "/storage/sdcard0/Android/media/com.whatsapp/WhatsApp/Media"
    "/sdcard/DCIM"
    "/sdcard/Recordings"
    "/sdcard/snapseed"
    "/sdcard/Documents"
)

# Solicitar la ruta donde se realizará el respaldo
read -p "Ingrese la ruta donde se guardará el respaldo: " BACKUP_DIR

# Verificar que la ruta de respaldo existe
if [ ! -d "$BACKUP_DIR" ]; then
    echo "La ruta $BACKUP_DIR no existe. Creando la ruta..."
    mkdir -p "$BACKUP_DIR"
fi

# Checar la disponibilidad de dispositivos con el comando adb
if ! command -v adb &> /dev/null; then
    echo "El comando adb no está disponible. Instale las dependencias necesarias."
    exit 1
fi

# Checar la existencia de dispositivos disponibles
DEVICES=$(adb devices | tail -n +2 | cut -f 1)

if [ -z "$DEVICES" ]; then
    echo "No se encontraron dispositivos disponibles."
    exit 1
fi

# Función para borrar los datos de un directorio
function clear_directory() {
    local DIR="$1"
    read -p "¿Está seguro que desea borrar los datos de $DIR? (S/N)" CONFIRM
    if [ "$CONFIRM" = "S" ]; then
        rm -rf "$DIR"/*
        echo "Se borraron los datos de $DIR."
    fi
}

# Menú principal
while true; do
    echo "Menú principal:"
    echo "1. Hacer respaldo"
    echo "2. Borrar datos de origen"
    echo "3. Instalar dependencias"
    echo "4. Salir"
    read -p "Seleccione una opción: " OPTION

    case "$OPTION" in
        1)
            # Hacer respaldo
            for DIR in "${DIRS[@]}"; do
                # Extraer el nombre del directorio para mostrarlo en la barra de progreso
                DIRNAME=$(basename "$DIR")
                echo "Haciendo respaldo de $DIRNAME..."
                adb pull -a "$DIR" "$BACKUP_DIR/$DIRNAME" | pv -s "$(du -sb "$DIR" | awk '{print $1}')" > /dev/null
            done
            echo "Respaldo completo."
            ;;
        2)
            # Borrar datos de origen
            # Mostrar un submenú con la lista de directorios a respaldar,
            # y permitir que el usuario seleccione uno para borrar sus datos.
            echo "Seleccione un directorio para borrar sus datos:"
            for i in "${!DIRS[@]}"; do
                echo "$i. ${DIRS[$i]}"
            done
            read -p "Seleccione una opción: " CLEAR_OPTION
            clear_directory "${DIRS[$CLEAR_OPTION]}"
            ;;
        3)
            # Instalar dependencias
            # Verificar si el comando adb está instalado. Si no lo está,
            # instalarlo usando el gestor de paquetes de la distribución.
            if ! command -v adb &> /dev/null; then
                echo "Instalando adb..."
                sudo apt-get update
                sudo apt-get install android-tools-adb
           
