<<<<<<< HEAD
# Este paquete puede usarse para imputar valores perdidos en
# variables de todo tipo
require(mice)

# se usa el conjunto airquality
datos <- airquality

# se fuerzan algunos datos perdidos adicionales
datos[4:10,3] <- rep(NA,7)
datos[1:5,4] <- NA

# se determina el numero de instancias sin datos perdidos y con datos
# perdidos. A observar la comodidad de uso de las funciones ccn e icn
completos <- ccn(datos)
incompletos <- icn(datos)
cat("Datos completos: ",completos, " e incompletos: ",incompletos,"\n")

# se realiza la imputacion
imputados <- mice(datos)

# se completa el conjunto de datos con las imputaciones
datosImputados <- complete(imputados)

# se determina el numero de instancias sin datos perdidos y con datos
# perdidos en la parte ya limpia
completos <- ccn(datosImputados)
incompletos <- icn(datosImputados)
cat("Datos completos: ",completos, " e incompletos: ",incompletos,"\n")

# se muestra la imputacion para Ozone
imputados$imp$Ozone

# Se muestra un grafico para comprobar la distribucion de Ozone en los
# datos imputados en relacion a otras variables
xyplot(imputados,Ozone ~ Wind+Temp+Solar.R,pch=18,cex=1)

# Se muestran las densidades de los datos imputados respecto de los
# observados
densityplot(imputados)

# Se muestran los diagramas de caja para las imputaciones
=======
# Este paquete puede usarse para imputar valores perdidos en variables de todo tipo
require(mice)
require(lattice) # Necesario para xyplot, densityplot y bwplot

# Se usa el conjunto airquality
datos <- airquality

# Se fuerzan algunos datos perdidos adicionales
datos[4:10, 3] <- rep(NA, 7)
datos[1:5, 4]  <- NA

# Se determina el numero de instancias sin datos perdidos y con datos perdidos
# (Cambiado datos_filtrados -> datos)
completos   <- sum(complete.cases(datos))
incompletos <- sum(!complete.cases(datos))
cat("Datos completos: ", completos, " e incompletos: ", incompletos, "\n")

# Se realiza la imputacion
imputados <- mice(datos)

# Se completa el conjunto de datos con las imputaciones
datosImputados <- complete(imputados)

# Se determina el numero de instancias sin datos perdidos y con datos perdidos en la parte ya limpia
completos   <- sum(complete.cases(datos))
incompletos <- sum(!complete.cases(datos))
cat("Datos completos: ", completos, " e incompletos: ", incompletos, "\n")

# Se muestra la imputacion para Ozone
imputados$imp$Ozone

# Graficos de diagnostico
xyplot(imputados, Ozone ~ Wind + Temp + Solar.R, pch = 18, cex = 1)
densityplot(imputados)
>>>>>>> 34d5046 (Ejercicios mapreduce en proceso)
bwplot(imputados)