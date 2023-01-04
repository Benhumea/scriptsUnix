#Creara una carpeta que llevara como nombre el año actual y dentro de las misma creara una carpeta con los 12 meses de año presedidos por 3 digitos
#cabe mencionar que el script funciona en unas bash
#obtenemos el año actual
ano=$(date +%Y)

#creamos la carpeta
mkdir -p "$ano"
# creamos un array con el nombre de los meses
meses=("001Enero" 
"002Febrero" "003Marzo" "004Abril" "005Mayo" "006Junio" "007Julio" "008Agosto" "009Septiembre" "010Octubre" "011Noviembre" "012Diciembre")

#Iteramos sobre el array para crear una carpeta con cada uno de los elementos
#Se modifica la declaracion del array y la iteracin sobre él para adaptarse a la sintaxis de zsh.
for i in {1..12}; do 
    mes=${meses[i]}
    mkdir "$ano/$mes"
done
