##########################################################################################################################
####                       CURSO DE ESPECIALIZACIÓN EN INTELIGENCIA ARTIFICIAL Y BIG DATA                             ####    
####                                          BIG DATA APLICADO                                                       ####    
####                            ALMACENES DE DATOS - Proceso ETL - Transformación                                     ####    
##########################################################################################################################

#Carga de las librerías que se usarán a lo largo del Script
library(Hmisc)
library(describer)
library(fBasics)
library(mice)
library(VIM)
library(robCompositions) # No disponible para todas las versiones de R
library(outliers)
library(mvoutlier)


## Definición del Working Directory
setwd("~/Desktop/JulioA/CURSOS/Curso_JJCC/BDA/GS-II/Ejemplos")

## Carga del conjunto de datos
source("lecturaDatos.R")

#Se observa el tipo de dato de los conjuntos de entrenamiento y prueba
class(datos) #data.frame

######################################################################
##                  ESTUDIO PRELIMINAR DE LOS DATOS                 ## 
######################################################################

#Se obtiene la longitud del dataset (largo y ancho) para hacernos una idea de sus dimensiones
instancias <- nrow(datos) #2000 instancias en el conjunto de entrenamiento
variables  <- ncol(datos) #51   variables

#Obtención de los nombres de las variables que componen el dataset
names(datos)
#Visión preliminar del dataset
head(datos)
View(datos)

#Clasificación de las Variables del Dataset en Discretas y Continuas
#Variables Continuas
continuas       <- c(1,2,3,4,22,23,24,29,30,31,32,41,42,43,49)
#Variables Discretas 
discretas       <- c(5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,25,26,27,33,34,35,37,38,39,48,50)  
#Variables Nominales
nominales       <- c(40,44,45,46,47,51)

#Obtención del resumen para cada variable 
summary(datos[,discretas]) #Resumen para variables Discretas
summary(datos[,continuas]) #Resumen para variables Continuas
summary(datos[,nominales]) #Resumen para variables Nominales

str(datos[,discretas])  #Resumen str para variables Discretas
str(datos[,continuas])  #Resumen str para variables Continuas
str(datos[,nominales])  #Resumen str para variables Nominales

#fix(train)

describe(datos[,discretas]) #Resumen describe para variables Discretas
describe(datos[,discretas]) #Resumen describe para variables Continuas
describe(datos[,discretas]) #Resumen describe para variables Nominales


#Gráficos que permitan una mejor visualización de los datos
boxplot(datos[,continuas], main = "Variables continuas")
continuas <- c(1,2,3,4,22,23,24,29,30,31,32,41,42,43)
boxplot(datos[,continuas], main = "Variables continuas")
boxplot(datos[,discretas], main = "Variables discretas")
discretas <- c(5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,25,26,27,33,34,35,37,38,39)
boxplot(datos[,discretas], main = "Variables discretas")

#Se vuelven a definir todas las variables continuas y discretas 
#Variables Continuas
continuas       <- c(1,2,3,4,22,23,24,29,30,31,32,41,42,43,49)
#Variables Discretas 
discretas       <- c(5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,25,26,27,33,34,35,37,38,39,48,50)


######################################################################
##                  IMPUTACIÓN DE VALORES PERDIDOS                  ## 
######################################################################

#Se aplica el filtrado de instancias con cierto porcentaje de datos perdidos para descartar
#instancias en que el porcentaje supera un cierto límite. 
source("filtrado.R")
#La ejecución de este script genera el fichero UGR2016_tra_keel_filtered.csv, el cual contiene los datos filtrados
# y será el fichero sobre el cual se trabajará a continuación para la imputación de valores perdidos. 

##################################################
#Imputación de Valores perdidos con Paquete Mice##
##################################################

datos_filtrados <- lecturaDatos("","Data-filtered.csv")
patron <- md.pattern(datos_filtrados)
print(patron)

#Visualización de la información anterior, utilizando el paquete VIM
X11()
aggr_plot <- aggr(datos_filtrados, col = c("blue","red"),numbers = TRUE, sortVars = TRUE, labels = names(datos_filtrados), cex.axis = .7, gap = 3, ylab = c("Datos perdidos","Patron"))

#Una vez obtenido el patrón, se consultan los datos completos e incompletos
completos   <- ccn(datos_filtrados)
incompletos <- icn(datos_filtrados)
cat("Datos completos:",completos,"e incompletos",incompletos,"\n")

#Se procede a la imputación
imputados_mice <- mice(datos)

#Se completa el conjunto de datos con los datos imputados
datos_filtrados_imputados_mice <- complete(imputados_mice)

#Obtención del número de instancias con y sin datos perdidos en la parte ya limpia. 
completos   <- ccn(datos_filtrados_imputados_mice)
incompletos <- icn(datos_filtrados_imputados_mice)
cat("Datos completos:",completos,"e incompletos",incompletos,"\n")

#Visualización para ver si este método de imputación es bueno o no lo suficiente 
xyplot(imputados_mice, class ~ datos$AA_freq_central_G + datos$AA_freq_central_M + datos$AA_freq_central_Y , pch = 18, cex=1)
densityplot(imputados_mice)
bwplot(imputados_mice)

#############################################################
#Imputación de Valores perdidos con Paquete robCompositions##
#############################################################

#¡OJO!: ¡Este método de imputación solo es válido para variables continuas!

#Se obtienen los datos completos e incompletos pero solo para variables continuas
completos_rob <- ccn(datos_filtrados[,continuas])
incompletos_rob <- icn(datos_filtrados[,continuas])
cat("Datos Completos:",completos, " e incompletos", incompletos,"\n")

#Imputación
imputados_rob <- impKNNa(datosanoma_filtrados_imputados_mice[,continuas])
plot(imputados_rob,which=3)

######################################################################
##                    DETECCIÓN DE DATOS ANÓMALOS                   ## 
######################################################################

#Detección de datos anómalos con el paquete outliers
source("anomalias.R")
#######QUÉ HACER CON LAS INSTANCIAS ANÓMALAS######

#Detección de datos anómalos con el paquete mvoutlier
# se analizan los datos en busca de anomalias. El grafico
# resultante muestra en rojo los datos considerados considerados
# como anomalos
resultados <- uni.plot(datos_filtrados_imputados_mice[,1:10])
resultados
# a partir de resultado es posible conocer las instancias en que
# aparece algun dato anomalo. Esto podria usarse para filtrar las
# instancias y quedarnos con aquellas en que no haya anomalias (o
# bien aplicar alguna tecnica para modificar sus valores)
print(resultados$outliers)

# seleccion de instancias sin anomalias
datosFinales <- datos_filtrados_imputados_mice[!resultados$outliers, ]

######################################################################
##                         TRANSFORMACIÓN                           ## 
######################################################################


source("transformacion.R") #Centrado y Escalado sobre el conjunto de datos
#head(datosFinales)
#Creamos un nuevo dataframe, con los valores centralizados de las variables continuas que aparecen en datos_centralizaos 
#y las variables discretas
datosFinales <- data.frame(datosFinales_escalados,datos[,nominales])

######################################################################
##                         DISCRETIZACIÓN                           ## 
######################################################################

#Uso del Script de Discretizaci?n obteniendo 
source("discretizacion.R")
#Este script obtiene los data.frames
#datosdiscretos_cm      --> Contiene los datos discretizados mediante el metodo caim
#datosdiscretos_cmAmeva --> Contiene los datos discretizados mediante el metodo ameva
#datosdicretos_cmCacc   --> Contieen los datos discretizados mediante el metodo cacc

######################################################################
##                  SELECCIÓN DE CARACTERÍSTICAS                    ## 
######################################################################

#Método best.first.search: No se puede hacer ya que la función de evaluación es válida solo para el conjunto de datos Iris del Script
#Características seleccionadas por cfs
source("fSelector-cfs.R")
#Caracteristicas seleccionadas por chisquared
source("fSelector-chiSquared.R")
#Características seleccionadas por el método de Consistencias
source("fSelector-consistency.R")




