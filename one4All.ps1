# Ruta del directorio que deseas respaldar
$sourceDirectory = "D:\Escaneo - copia"
# Nombre del directorio de respaldo
$backupDirectoryName = "backupGen"
# Busca una unidad USB conectada al sistema
$usbDrive = Get-WmiObject Win32_LogicalDisk | Where-Object {$_.DriveType -eq 2} | Sort-Object -Descending FreeSpace | Select-Object -First 1
if (!$usbDrive) {
    Write-Host "No se ha encontrado una unidad USB conectada al sistema."
} else {
    # Ruta de la unidad USB encontrada
    $usbPath = $usbDrive.DeviceID + "\"
    # Comprueba si el directorio de respaldo existe en la unidad USB y, de ser necesario, lo crea
    $backupDirectoryPath = Join-Path $usbPath $backupDirectoryName
    if (!(Test-Path $backupDirectoryPath)) {
        New-Item -ItemType Directory -Path $backupDirectoryPath | Out-Null
        Write-Host "Se ha creado el directorio de respaldo $backupDirectoryName en la unidad USB."
    }
    # Comprueba si el directorio de origen existe y, de ser necesario, informa al usuario y sale del script
    if (!(Test-Path $sourceDirectory)) {
        Write-Host "El directorio de origen $sourceDirectory no existe."
        return
    }
    # Realiza el respaldo del directorio en la unidad USB
    $backupDestination = Join-Path $backupDirectoryPath (Split-Path -Leaf $sourceDirectory)
    Robocopy $sourceDirectory $backupDestination /E /PURGE | Out-Null
    Write-Host "El respaldo del directorio $sourceDirectory se ha completado en la unidad USB $usbDrive."
    # Borra los archivos originales de forma irrecuperable
    $wipeCommand = "cipher /w:$sourceDirectory"
    Invoke-Expression $wipeCommand | Out-Null
    Write-Host "Se ha eliminado de forma irrecuperable el contenido del directorio $sourceDirectory."
}