# !/bin/zsh
# Assign the downloads folder to a variable
descarga_folder="$(xdg-user-dir DOWNLOAD)"

# Search for files that begin with "firefox" and end with ".bz2" in the downloads folder
archivo=$(find $descarga_folder -name "firefox*bz2")

echo "
 __      __        .__   __   .__ 
/  \    /  \_____  |  | |  | _|__|
\   \/\/   /\__  \ |  | |  |/ /  |
 \        /  / __ \|  |_|    <|  |
  \__/\  /  (____  /____/__|_ \__|
       \/        \/          \/   
Firefox Updater version 1.1
"

# If a file is found
if [ -n "$archivo" ]; then
    echo "archivo encontrado $archivo en la carpeta Descargas"
else
    echo "No se encontro el archivo de actualización."
    read -p "Ingresa la URL de descarga:" url
    wget --output-document=$descarga_folder/firefox.tar.bz2 $url
    archivo=$descarga_folder/firefox.tar.bz2
fi

if [ -f $archivo ]; then
    # Navigate to the "/usr/lib/firefox-esr" directory
    cd /usr/lib/firefox-esr
    #Check if Firefox is running 
    if pgrep -x "firefox-bin"; then
        echo "Firefox esta en uso, por favor cierrelo para actualizar."
        exit 1
    fi
    #Eliminamos la instalacion anterior 
    cd /usr/lib/firefox-esr
    rm -rf **
    # Volvemos a la carpeta de descarga para continuar con la actualizacion
    cd $descarga_folder
    # Extract the "firefox.tar.bz2" file
    tar -xvf $archivo
    #Move the extracted files to "/usr/lib/firefox-esr"
    firefox_folder=`find . -maxdepth 1 -type d -name "firefox*"`
    sudo mv -f $firefox_folder/* /usr/lib/firefox-esr
    # Remove the extracted folder
    sudo rm -rf $firefox_folder
    rm $descarga_folder/firefox.tar.bz2 
    echo "Firefox se ha actualizado."
    # Launch Firefox
    sudo walky
    /usr/lib/firefox-esr/firefox-bin %u &> /dev/null & disown
else
    echo "The file $archivo does not exist"
    exit 1
fi
