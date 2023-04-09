#!/bin/bash

# Pedir directorio de origen
echo "Ingrese el directorio de origen"
echo -e "1)Ruta actual.\n2)otra Ruta."
read opcion

if [ $opcion == "1" ]; then
    origen=$(pwd)
elif [ $opcion == "2" ]; then
    echo "Ingrese el directorio de origen:"
    read origen
fi

# Pedir directorio de destino y crearlo si no existe
echo "Ingrese el directorio de destino:"
read destino

if [ ! -d $destino ]; then
    echo "El directorio de destino no existe, ¿desea crearlo? (s/n)"
    read respuesta
    if [ $respuesta == "s" ]; then
        mkdir -p $destino
        echo "Directorio creado exitosamente."
    else
        echo "Saliendo del script."
        exit
    fi
fi

# Verificar si se requieren permisos de administrador
permisos=$(stat -c %U $destino)
usuario=$(whoami)

if [ $permisos != $usuario ]; then
    echo "Se requieren permisos de administrador para mover los archivos al directorio de destino."
    echo "Ingrese la contraseña de administrador:"
    su -c "chmod u+w $destino"
fi

# Mover archivos según mes de creación
for archivo in $origen/*; do
    mes=$(date -r $archivo +%m)
    case $mes in
        01) carpeta=001Enero ;;
        02) carpeta=002Febrero ;;
        03) carpeta=003Marzo ;;
        04) carpeta=004Abril ;;
        05) carpeta=005Mayo ;;
        06) carpeta=006Junio ;;
        07) carpeta=007Julio ;;
        08) carpeta=008Agosto ;;
        09) carpeta=009Septiembre ;;
        10) carpeta=010Octubre ;;
        11) carpeta=011Noviembre ;;
        12) carpeta=012Diciembre ;;
    esac

    # Crear carpeta si no existe
    if [ ! -d $destino/$carpeta ]; then
        mkdir -p $destino/$carpeta
    fi

    # Renombrar archivo si ya existe en la carpeta de destino
    if [ -f $destino/$carpeta/$(basename $archivo) ]; then
        contador=1
        while [ -f $destino/$carpeta/$(basename $archivo)_copia$contador ]; do
            let contador++
        done
        mv $archivo $destino/$carpeta/$(basename $archivo)_copia$contador
    else
        mv $archivo $destino/$carpeta
    fi
done

# Abrir carpeta de destino en el explorador predeterminado
xdg-open $destino
