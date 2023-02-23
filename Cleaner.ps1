# Ruta del directorio que deseas eliminar
$directoryPath = "D:\ARCHIVOS MC-MNV - copia"
# Numero de veces que se sobrescribirá el contenido de los archivos antes de ser eliminados
$numberOfOverwrites = 5
# Genera el contenido aleatorio que se utilizará para sobrescribir los archivos
$randomBytes = New-Object byte[] 1024
$randomNumberGenerator = [System.Security.Cryptography.RNGCryptoServiceProvider]::Create()
$randomNumberGenerator.GetBytes($randomBytes)
# Recorre todos los archivos dentro del directorio y los sobrescribe varias veces con contenido aleatorio
Get-ChildItem $directoryPath -Recurse | ForEach-Object {
    if($_.GetType().Name -eq "FileInfo"){
        for ($i = 0; $i -lt $numberOfOverwrites; $i++) {
            $fileStream = New-Object System.IO.FileStream($_.FullName, [System.IO.FileMode]::Open)
            $fileStream.Write($randomBytes, 0, $randomBytes.Length)
            $fileStream.Dispose()
        }
    }
}
# Elimina el directorio y todo su contenido de forma permanente sin mostrar ningún mensaje en la consola
Remove-Item $directoryPath -Force -Recurse -ErrorAction SilentlyContinue -Confirm:$false
# Muestra un mensaje de finalizado
Write-Host "El directorio $directoryPath ha sido eliminado de forma permanente."