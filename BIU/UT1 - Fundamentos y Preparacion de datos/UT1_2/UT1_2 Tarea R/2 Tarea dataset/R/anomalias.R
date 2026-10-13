# Cargar la librería necesaria para la función outlier()
require(outliers)

# Se carga el archivo con las funciones de lectura de datos
source("../EjemplosR/lecturaDatos.R")

path <- "./"
file <- "../Data.csv"

# Lectura de los datos
datos <- lecturaDatos(path, file)

# Vector de columnas continuas (revisar que las columnas existan en el dataset)
continuas <- c(1, 2, 3, 4, 22, 23, 24, 29, 30, 31, 32, 41, 42, 43, 49)

# Seleccionar solo las variables continuas sobre el dataframe leído
datos_continuas <- datos[, continuas]

# Detección de anomalías
anomalos <- outlier(datos_continuas)
print(anomalos)

 
 