# Ruta del directorio que deseas respaldar
$sourceDirectory = "C:\Users\jose.benhumea"
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
    # Comprueba si hay suficiente espacio libre en la unidad USB para el respaldo y, de ser necesario, informa al usuario y sale del script
    $sourceDirectorySize = (Get-ChildItem -Path $sourceDirectory -Recurse | Measure-Object -Property Length -Sum).Sum
    $usbDriveFreeSpace = $usbDrive.FreeSpace
    if ($sourceDirectorySize -gt $usbDriveFreeSpace) {
        Write-Host "No hay suficiente espacio libre en la unidad USB para el respaldo del directorio de origen."
        return
    }
    # Realiza el respaldo del directorio en la unidad USB
    $backupDestination = Join-Path $backupDirectoryPath (Split-Path -Leaf $sourceDirectory)
    Robocopy $sourceDirectory $backupDestination /E /PURGE /NFL /NDL /NJH /NJS /R:0 /W:0 2>$null

    # Muestra un mensaje de finalizado
    Write-Host "El respaldo del directorio $sourceDirectory se ha completado en la unidad USB $usbDrive."
}