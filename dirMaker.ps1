#El siguiente script tiene como finalidad crear una carpeta que se nombre como el año en curso, dentro de esa carpeta crea una carpeta por mes y dentro de cada carpeta por mes crea una por cada semana, comenzando la semana en domingo.

#Version 1.0

# Obtener el año actual
$year = (Get-Date).Year
# Crear un directorio con el año actual
New-Item -ItemType Directory -Path ".\$year" -ErrorAction Ignore
# Iterar a través de cada mes del año
for ($i = 1; $i -le 12; $i++) {
  # Obtener el nombre del mes
  $monthName = (Get-Date -Month $i -Year $year).ToString("MMMM")
  # Crear una carpeta con el nombre del mes
  New-Item -ItemType Directory -Path ".\$year\$($i.ToString("000"))$monthName" -ErrorAction Ignore
}
<#código anterior creará una carpeta por cada mes del año con el formato XXXNombreMes, donde XXX es
el número del mes con tres dígitos y NombreMes es el nombre del mes en mayúsculas.
Todas las carpetas se crearán dentro de una carpeta con el nombre del año actual.
El parámetro -ErrorAction Ignore se utiliza para ignorar cualquier error que se produzca 
al intentar crear una carpeta que ya existe. De esta manera, no se sobrescribirá ni se eliminará ningún dato.#>

