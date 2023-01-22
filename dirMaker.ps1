#El siguiente script tiene como finalidad crear una carpeta que se nombre como el año en curso, dentro de esa carpeta crea una carpeta por mes y dentro de cada carpeta por mes crea una por cada semana, comenzando la semana en domingo.

#Version 2.0 Se agrega la funcionalidad de las carpetas por semana

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
  # Obtener el primer día del mes
  $firstDayOfMonth = (Get-Date -Month $i -Year $year).Date
  # Obtener el último día del mes
  $lastDayOfMonth = (Get-Date -Month $i -Year $year).AddMonths(1).AddDays(-1).Date
  # Iterar a través de cada semana del mes
  while ($firstDayOfMonth -le $lastDayOfMonth) {
    # Obtener el primer día de la semana
    $firstDayOfWeek = $firstDayOfMonth
    # Obtener el último día de la semana
    $lastDayOfWeek = $firstDayOfMonth.AddDays(6)
    # Si el último día de la semana es mayor que el último día del mes, ajustar el último día de la semana al último día del mes
    if ($lastDayOfWeek -gt $lastDayOfMonth) {
      $lastDayOfWeek = $lastDayOfMonth
    }
    # Crear una carpeta con el rango de fechas de la semana
    New-Item -ItemType Directory -Path ".\$year\$($i.ToString("000"))$monthName\Semana $($firstDayOfWeek.ToString("dd-MM-yyyy")) - $($lastDayOfWeek.ToString("dd-MM-yyyy"))" -ErrorAction Ignore
    # Actualizar el primer día del mes al siguiente lunes
    $firstDayOfMonth = $firstDayOfMonth.AddDays(7)
  }
}