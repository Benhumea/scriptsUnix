$IP = "10.136.4"

for ($i = 1; $i -le 255; $i++) {
$ipHost = $IP + "." + $i
$Test = Test-Connection -ComputerName $ipHost -Count 1 -Quiet
if ($Test) {
$Computer = Get-WmiObject -Class Win32_ComputerSystem -ComputerName $ipHost -ErrorAction SilentlyContinue
if ($Computer) {
$ComputerName = $Computer.Name
Write-Host "La computadora $ComputerName se encuentra conectada en la dirección IP $ipHost"
}
}
}