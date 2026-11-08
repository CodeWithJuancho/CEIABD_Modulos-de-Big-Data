# Referencias a los paquetes necesarios para disponer
# del conjunto de datos y de la funcion de visualizacion
# del patron de datos perdidos
require(mice)
require(VIM)

# se usan datos disponibles en este paquete, sobre calidad
# del aire: 6 variables y 153 instancias. Se visualiza un
# grafico que nos indica la forma en que se distribuyen los
# datos perdidos
datos <- airquality

# se fuerzan algunos datos perdidos adicionales
datos[4:10,3] <- rep(NA,7)
datos[1:5,4] <- NA

# se genera el grafico de distribucion de datos perdidos. Solo
# se consideran las variables con datos perdidos
aggr_plot <- aggr(datos[,1:4], col=c('blue','red'), numbers=TRUE, 
                  sortVars=TRUE, labels=names(data), cex.axis=.5, 
                  gap=1, ylab=c("Gráfico de datos perdidos","Patrón"))

# se muestra informacion sobre algunas de las variables en que 
# aparecen los datos perdidos
marginplot(datos[,1:2])

