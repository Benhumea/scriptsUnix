# !/bin/bash
# Assign the downloads folder to a variable
descarga_folder="/home/walky/Descargas"

# Search for files that begin with "firefox" and end with ".bz2" in the downloads folder
archivo=$(find $descarga_folder -name "firefox*bz2")

# If a file is found
if [ -n "$archivo" ]; then
    echo "Found file $archivo in the downloads folder"
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
    # Extract the "firefox.tar.bz2" file
    tar -xvf $archivo
    #Move the extracted files to "/usr/lib/firefox-esr"
    firefox_folder=`find . -maxdepth 1 -type d -name "firefox*"`
    sudo mv -f $firefox_folder/* /usr/lib/firefox-esr
    # Remove the extracted folder
    sudo rm -rf $firefox_folder
    echo "Firefox se ha actualizado."
    # Launch Firefox
    ./firefox-bin &> /dev/null & disown
else
    echo "The file $archivo does not exist"
    exit 1
fi
