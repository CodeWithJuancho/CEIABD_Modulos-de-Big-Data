#!/bin/bash
Fecha=$(date +"%d-%m-%Y")
echo $Fecha
cp ../users/extracted/users.csv ../users/processed/${Fecha}_processed_users.txt
python3 python.py