require(outliers)


# se carga el archivo con las funcione de lectura de datos
source("/home/bladimir/Desktop/proyecto_0/CE_IABD_BIU_SPS/BIU/UT1 - Fundamentos y Preparacion de datos/UT1_2/UT1_2 Tarea R/2 Tarea dataset/R/lecturaDatos.R", chdir=TRUE)

path <- "/home/bladimir/Desktop/proyecto_0/CE_IABD_BIU_SPS/BIU/UT1 - Fundamentos y Preparacion de datos/UT1_2/UT1_2 Tarea R/2 Tarea dataset"
file <- "/Data.csv"

# lectura de los datos
datos <- lecturaDatos(path,file)

continuas       <- c(1,2,3,4,22,23,24,29,30,31,32,33,41,42,43,49)
datos           <- datos_filtrados_imputados_mice[,continuas]
# deteccion de anomalias para las variable 1 a 3. Observad 
# que no tiene sentido considerar variables de tipo discreto
# en este analisis. La funcion devuelve el valor (o valores)
# considerados anomalos para las variable de interes. Este
# metodo solo considera las desviaciones con respecto a los
# valores de cada variable (no relaciones con otras variables)
anomalos <- outlier(datos[,])
print(anomalos)

 
 