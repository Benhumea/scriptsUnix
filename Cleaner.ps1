# Ruta del directorio que deseas eliminar
$directoryPath = "C:\MC_MNV2340019"
# Numero de veces que se sobrescribirá el contenido de los archivos antes de ser eliminados
$numberOfOverwrites = 5
# Genera el contenido aleatorio que se utilizará para sobrescribir los archivos
$randomBytes = New-Object byte[] 1024
$randomNumberGenerator = [System.Security.Cryptography.RNGCryptoServiceProvider]::Create()
$randomNumberGenerator.GetBytes($randomBytes)
# Recorre todos los archivos dentro del directorio y los sobrescribe varias veces con contenido aleatorio
Get-ChildItem $directoryPath -Recurse | ForEach-Object {
    if($_.GetType().Name -eq "FileInfo"){
        Write-Host "Sobrescribiendo archivo $($_.FullName)..."
        for ($i = 0; $i -lt $numberOfOverwrites; $i++) {
            $fileStream = New-Object System.IO.FileStream($_.FullName, [System.IO.FileMode]::Open)
            $fileStream.Write($randomBytes, 0, $randomBytes.Length)
            $fileStream.Dispose()
        }
    }
}
# Elimina el directorio y todo su contenido de forma permanente
Write-Host "Eliminando directorio de forma permanente..."
Remove-Item $directoryPath -Force -Recurse