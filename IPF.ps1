#InputDevicesFinder v1.0 Para que busque un tipo de dispositivo de entrada busca en la pagina web del producto
#para que indique de tipo de dipositivo se trata en un futuro, ver la forma que nos indique el tipo de dispositivo y la IP a la que esta asociada
$IP = "10.136.1"
$CameraName = "Webex"

for ($i = 1; $i -le 255; $i++) {
$ip_host = $IP + "." + $i
$Test = Test-Connection -ComputerName $ip_host -Count 1 -Quiet
if ($Test) {
try {
$Response = Invoke-WebRequest -Uri "http://$ip_host" -TimeoutSec 5
if ($Response.Content -match $CameraName) {
Write-Host "La cámara web de $CameraName se encuentra en la dirección IP $ip_host"
}
} catch {
# Catch any errors
}
}
}