require(robCompositions)
require(mice)

# se usa el conjunto de datos de calidad del aire, en las
# mismas condiciones que vimos con anterioridad
datos <- airquality

# se fuerzan algunos datos perdidos adicionales
datos[4:10,3] <- rep(NA,7)
datos[1:5,4] <- NA

# se determina el numero de instancias sin datos perdidos y con datos
# perdidos. A observar la comodidad de uso de las funciones ccn e icn
completos <- ccn(datos)
incompletos <- icn(datos)
cat("Datos completos: ",completos, " e incompletos: ",incompletos,"\n")

# se hace la imputacion
imputados <- impKNNa(datos)

# Ahora puede visualizarse alguna informacion sobre la forma
# en que se hizo la imputacion. El segundo argumento indica el
# tipo de grafico a obtener: 3 indica que se trata de un diagrama
# ternario que permite representar la forma en que hizo la imputacion
# de los valores perdidos (KNN)
plot(imputados, which=3)