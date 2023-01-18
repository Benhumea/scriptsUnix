#!/bin/bash
# Funcion que debe ir enbebida en el archivo zshrc para borrar irrecuperablemente un archivo
function rmkill(){
	scrub -p dod $1; shred -zun 20 -v $1
}