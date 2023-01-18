#!/bin/zsh

folder1=$1
folder2=$2

echo "Listando archivos en $folder1:"
# Obtener lista de archivos en folder1 y mostrando detalles con find
files1=($(find $folder1 -type f))

echo "Listando archivos en $folder2:"
# Obtener lista de archivos en folder2 y mostrando detalles con find
files2=($(find $folder2 -type f))

flag=0

# Print header
printf "%-40s %-40s\n" "Archivos en $folder1" "Archivos en $folder2"

# Iterar a través de la lista de archivos en folder1
for file1 in $files1
do
  # Iterar a través de la lista de archivos en folder2
  for file2 in $files2
  do
    # Comparar los nombres de archivo
    if [[ $file1 == $file2 ]]; then
        flag=1
        # Print file names in columns in red
        printf "\033[31m%-40s %-40s\033[0m\n" $file1 $file2
    fi
  done
done

if [ $flag -eq 0 ]
then
    echo "No se encontraron archivos duplicados"
fi
