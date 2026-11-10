library(outliers)


# se carga el archivo con las funcione de lectura de datos
source("2 Tarea dataset/R/lecturaDatos.R")

path <- "2 Tarea dataset/R"
file <- "../Data-filtered.csv"

# lectura de los datos
datos <- lecturaDatos(path,file)

continuas       <- c(1,2,3,4,22,23,24,29,30,31,32,3,41,42,43,49)
datos           <- datos[, continuas]
# deteccion de anomalias para las variable 1 a 3. Observad 
# que no tiene sentido considerar variables de tipo discreto
# en este analisis. La funcion devuelve el valor (o valores)
# considerados anomalos para las variable de interes. Este
# metodo solo considera las desviaciones con respecto a los
# valores de cada variable (no relaciones con otras variables)
anomalos <- outlier(datos)
print(anomalos)
