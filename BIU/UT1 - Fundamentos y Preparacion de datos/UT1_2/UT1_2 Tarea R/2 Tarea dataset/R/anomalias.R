<<<<<<< HEAD
<<<<<<< HEAD
require(outliers)


# se carga el archivo con las funcione de lectura de datos
source("D:/EjemplosR/lecturaDatos.R")

path <- "D:/EjemplosR"
file <- "../Data.csv"

# lectura de los datos
datos <- lecturaDatos(path,file)

continuas       <- c(1,2,3,4,22,23,24,29,30,31,32,3,41,42,43,49)
datos           <- datos_filtrados_imputados_mice[,continuas]
# deteccion de anomalias para las variable 1 a 3. Observad 
# que no tiene sentido considerar variables de tipo discreto
# en este analisis. La funcion devuelve el valor (o valores)
# considerados anomalos para las variable de interes. Este
# metodo solo considera las desviaciones con respecto a los
# valores de cada variable (no relaciones con otras variables)
anomalos <- outlier(datos[,])
print(anomalos)

 
=======
=======
>>>>>>> origin/alumno/DanielGlez
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

 
<<<<<<< HEAD
>>>>>>> 34d5046 (Ejercicios mapreduce en proceso)
=======
>>>>>>> origin/alumno/DanielGlez
 