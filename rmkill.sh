#!/bin/bash
#En esta implementación, se utiliza el comando "echo" para imprimir la lista de archivos, tr para cambiar los espacios por saltos de linea y "xargs" para procesar varios archivos a la vez utilizando -P0 para indicar que no se debe limitar el numero de procesos simultáneos, -n1 para indicar que se procese un solo archivo por vez y -I{} para indicar el placeholder donde se colocara cada archivo en el comando. Ademas se utiliza "pv" para mostrar una barra de progreso mientras se eliminan los archivos.
#Ten en cuenta que esta función no permite recuperar los archivos eliminados, utilizala con precaución.

function rmkill() {
  # Scrub and shred files
  echo "$@" | tr ' ' '\n' | xargs -P0 -n1 -I{} sh -c 'scrub -p dod {}; shred -zun 20 -v {} | pv -pet'
}
