#!/bin/bash

# Pedimos al usuario que ingrese el nombre del archivo de salida
read -p "Ingresa el nombre del archivo de salida: " output_file

# Creamos el archivo de salida y escribimos la primera línea
echo "Historial del clipboard:" > "$output_file"

# Creamos una lista para almacenar los enlaces ya vistos
seen_links=()

# Definimos una función que escribe el contenido actual del clipboard en el archivo de salida
function write_to_file {
    clipboard=$(xclip -selection clipboard -o)

    # Verificamos si el contenido del clipboard es un enlace
    if [[ "$clipboard" =~ ^(http|https)://.* ]]; then
        # Verificamos si el enlace actual ya ha sido visto antes
        if [[ " ${seen_links[@]} " =~ " ${clipboard} " ]]; then
            echo "Enlace repetido: $clipboard"
        else
            # Escribimos el enlace en el archivo de salida
            echo "$clipboard" >> "$output_file"

            # Agregamos el enlace a la lista de enlaces ya vistos
            seen_links+=("$clipboard")
        fi
    fi
}

# Creamos un bucle que se ejecuta hasta que se use Ctrl + C
while true; do
    # Escribimos el contenido actual del clipboard en el archivo de salida
    write_to_file

    # Esperamos 1 segundo antes de revisar el clipboard de nuevo
    sleep 1
done

# Si se presiona Ctrl + C, usamos los enlaces guardados para descargar los videos con la mejor resolución
if [ $? -eq 0 ]; then
    echo "Descargando videos con mejor resolución..."
    yt-dlp -a "$output_file" -f 'bestvideo[height>=1080]+bestaudio/best[height>=1080]' --merge-output-format mp4
fi
