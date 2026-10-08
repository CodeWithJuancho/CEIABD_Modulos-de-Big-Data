#!/bin/bash
# Recogemos la fecha y le damos el formato que queremos
fecha=$(date +%m_%d_%y)
# La mostramos por pantalla
echo $fecha
#Copiamos el archivo con el nombre nuevo que le hemos dado
cp ../users/extracted/users.csv ../users/processed/${fecha}_processed_users.txt
#Ejecutamos el script de python para procesar el archivo
python3 python.py