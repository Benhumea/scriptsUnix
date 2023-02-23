# Ruta del directorio que deseas eliminar
$directoryPath = "C:\MC_MNVclean1"
# Numero de veces que se sobrescribirá el contenido de los archivos antes de ser eliminados
$numberOfOverwrites = 5
# Genera el contenido aleatorio que se utilizará para sobrescribir los archivos
$randomBytes = New-Object byte[] 1024
$randomNumberGenerator = [System.Security.Cryptography.RNGCryptoServiceProvider]::Create()
$randomNumberGenerator.GetBytes($randomBytes)
# Obtiene la lista de archivos a eliminar
$fileList = Get-ChildItem $directoryPath -Recurse | Where-Object {$_.GetType().Name -eq "FileInfo"}
# Crea una barra de progreso
$progress = 0
$totalProgress = $fileList.Count * $numberOfOverwrites
$progressBar = New-Object System.Collections.Generic.List[int]
$percentComplete = 0
# Recorre todos los archivos dentro del directorio y los sobrescribe varias veces con contenido aleatorio
foreach ($file in $fileList) {
    Write-Host "Sobrescribiendo archivo $($file.FullName)..."
    for ($i = 0; $i -lt $numberOfOverwrites; $i++) {
        $fileStream = New-Object System.IO.FileStream($file.FullName, [System.IO.FileMode]::Open)
        $fileStream.Write($randomBytes, 0, $randomBytes.Length)
        $fileStream.Dispose()
        # Actualiza el progreso de la barra de progreso
        $progress += 1
        $percentComplete = [Math]::Round(($progress / $totalProgress) * 100)
        $progressBar.Add($percentComplete) | Out-Null
        Write-Progress -Activity "Eliminando directorio de forma permanente..." -PercentComplete $percentComplete -Status "Procesando archivos..." -CurrentOperation "Eliminando $($file.FullName)"
    }
}
# Elimina el directorio y todo su contenido de forma permanente
Write-Host "Eliminando directorio de forma permanente..."
Remove-Item $directoryPath -Force -Recurse
# Cierra la barra de progreso
Write-Progress -Activity "Eliminando directorio de forma permanente..." -Completed