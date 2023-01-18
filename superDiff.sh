#!/bin/zsh

echo "
 __      __        .__   __   .__ 
/  \    /  \_____  |  | |  | _|__|
\   \/\/   /\__  \ |  | |  |/ /  |
 \        /  / __ \|  |_|    <|  |
  \__/\  /  (____  /____/__|_ \__|
       \/        \/          \/   

"

folder1=$1
folder2=$2

echo "Listando archivos en $folder1:"
# Obtener lista de archivos en folder1  con find y solo mostrar archivos
files1=($(find $folder1 -type f))

echo "Listando archivos en $folder2:"
# Obtener lista de archivos en folder2  con find y solo mostrar archivos
files2=($(find $folder2 -type f))

duplicate_count=0

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
        duplicate_count=$((duplicate_count+1))
        # Print file names in columns in red
        printf "\033[31m%-40s %-40s\033[0m\n" $file1 $file2
    fi
  done
done

if [ $duplicate_count -eq 0 ]
then
    echo "No se encontraron archivos duplicados"
else
    echo "Se encontraron $duplicate_count archivos duplicados"
fi
