# Script que escanea las direcciones IP locales
# ademas de que guarda el resultadoen la ruta F:\dole.txt
#tenemos que cambiar el rango de la red en las comillas despues de computerName

@(1..254) | ForEach-Object {Test-Connection -ComputerName "192.168.0.$_" -Count 1 -ErrorAction SilentlyContinue} | Out-File F:\doble.txt