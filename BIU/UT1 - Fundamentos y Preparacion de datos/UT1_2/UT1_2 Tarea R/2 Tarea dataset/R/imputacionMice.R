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
bwplot(imputados)