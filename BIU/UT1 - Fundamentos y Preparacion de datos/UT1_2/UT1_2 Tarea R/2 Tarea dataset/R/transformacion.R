##########################################################################################################################
####                       CURSO DE ESPECIALIZACIÓN EN INTELIGENCIA ARTIFICIAL Y BIG DATA                             ####    
####                                           BIG DATA APLICADO                                                      ####    
####                             ALMACENES DE DATOS - Proceso ETL - Transformación                                     ####    
##########################################################################################################################

# Carga de las librerías necesarias
library(Hmisc)
library(describer)
library(fBasics)
library(mice)
library(VIM)
library(robCompositions)
library(outliers)
library(mvoutlier)
library(lattice)

## Definición dinámica del Working Directory
# Si se ejecuta en RStudio, establece la ruta donde está guardado este script;
# de lo contrario, mantiene el directorio de trabajo actual.
tryCatch({
  if (requireNamespace("rstudioapi", quietly = TRUE) && rstudioapi::isAvailable()) {
    setwd(dirname(rstudioapi::getActiveDocumentContext()$path))
  }
}, error = function(e) {
  # Si falla o se corre fuera de RStudio, usa el directorio de trabajo donde se lanzó R
  cat("Directorio de trabajo actual:", getwd(), "\n")
})

## Carga del conjunto de datos
source("lecturaDatos.R")

# Se observa el tipo de dato de los conjuntos
class(datos) # data.frame

######################################################################
##                   ESTUDIO PRELIMINAR DE LOS DATOS                ## 
######################################################################

# Dimensiones del dataset
instancias <- nrow(datos)
variables  <- ncol(datos)

# Nombres y primeras filas
names(datos)
head(datos)
# View(datos) # Descomentar en entorno interactivo

# Clasificación de las Variables del Dataset
continuas <- c(1, 2, 3, 4, 22, 23, 24, 29, 30, 31, 32, 41, 42, 43, 49)
discretas <- c(5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 25, 26, 27, 33, 34, 35, 37, 38, 39, 48, 50)  
nominales <- c(40, 44, 45, 46, 47, 51)

# Resúmenes
summary(datos[, discretas])
summary(datos[, continuas])
summary(datos[, nominales])

str(datos[, discretas])
str(datos[, continuas])
str(datos[, nominales])

describe(datos[, discretas])
describe(datos[, continuas])
describe(datos[, nominales])

# Gráficos preliminares
boxplot(datos[, continuas], main = "Variables continuas")
continuas_sub <- c(1, 2, 3, 4, 22, 23, 24, 29, 30, 31, 32, 41, 42, 43)
boxplot(datos[, continuas_sub], main = "Variables continuas (subconjunto)")

boxplot(datos[, discretas], main = "Variables discretas")
discretas_sub <- c(5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 25, 26, 27, 33, 34, 35, 37, 38, 39)
boxplot(datos[, discretas_sub], main = "Variables discretas (subconjunto)")

# Restaurar vectores completos
continuas <- c(1, 2, 3, 4, 22, 23, 24, 29, 30, 31, 32, 41, 42, 43, 49)
discretas <- c(5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 25, 26, 27, 33, 34, 35, 37, 38, 39, 48, 50)

######################################################################
##                  IMPUTACIÓN DE VALORES PERDIDOS                  ## 
######################################################################

# Filtrado de instancias con alto porcentaje de datos perdidos
source("filtrado.R")

##################################################
# Imputación de Valores perdidos con Paquete MICE
##################################################

datos_filtrados <- lecturaDatos("", "Data-filtered.csv")
patron <- md.pattern(datos_filtrados)
print(patron)

# Visualización del patrón con VIM
aggr_plot <- aggr(datos_filtrados, col = c("blue", "red"), numbers = TRUE, 
                  sortVars = TRUE, labels = names(datos_filtrados), 
                  cex.axis = .7, gap = 3, ylab = c("Datos perdidos", "Patron"))

# Casos completos e incompletos
completos   <- ccn(datos_filtrados)
incompletos <- icn(datos_filtrados)
cat("Datos completos:", completos, "e incompletos:", incompletos, "\n")

# Proceso de imputación MICE
imputados_mice <- mice(datos_filtrados)

# Completar dataframe
datos_filtrados_imputados_mice <- complete(imputados_mice)

# Verificación de instancias limpias
completos_post   <- ccn(datos_filtrados_imputados_mice)
incompletos_post <- icn(datos_filtrados_imputados_mice)
cat("Datos completos post-MICE:", completos_post, "e incompletos post-MICE:", incompletos_post, "\n")

# Diagnósticos gráficos
# (Nota: Verifica que las variables de la fórmula existan en tu dataset o sustitúyelas)
try(xyplot(imputados_mice, class ~ AA_freq_central_G + AA_freq_central_M + AA_freq_central_Y, pch = 18, cex = 1))
densityplot(imputados_mice)
bwplot(imputados_mice)

#############################################################
# Imputación de Valores perdidos con Paquete robCompositions
#############################################################

# Diagnóstico de completos en variables continuas
completos_rob   <- ccn(datos_filtrados[, continuas])
incompletos_rob <- icn(datos_filtrados[, continuas])
cat("Continuas - Completos:", completos_rob, "e incompletos:", incompletos_rob, "\n")

# Imputación KNN sobre variables continuas (corregida errata tipográfica)
imputados_rob <- impKNNa(datos_filtrados_imputados_mice[, continuas])

# Gráfico ternario con las 3 primeras variables continuas para evitar el Warning
plot(imputados_rob, which = 3, parts = 1:3)

######################################################################
##                    DETECCIÓN DE DATOS ANÓMALOS                   ## 
######################################################################

# Detección con paquete outliers
source("anomalias.R")

# Detección multivariante con mvoutlier sobre las primeras 10 variables
resultados <- uni.plot(datos_filtrados_imputados_mice[, 1:10])
print(resultados$outliers)

# Selección de instancias sin anomalías
datosFinales <- datos_filtrados_imputados_mice[!resultados$outliers, ]

######################################################################
##                         TRANSFORMACIÓN                           ## 
######################################################################

# Centrado y escalado
source("transformacion.R")

# Unión de continuas escaladas con variables nominales originales
# (Asegúrate de que 'datosFinales_escalados' se genere en transformacion.R)
if (exists("datosFinales_escalados")) {
  datosFinales <- data.frame(datosFinales_escalados, datos[!resultados$outliers, nominales])
}

######################################################################
##                         DISCRETIZACIÓN                           ## 
######################################################################

source("discretizacion.R")
# Genera: datosdiscretos_cm, datosdiscretos_cmAmeva, datosdicretos_cmCacc

######################################################################
##                  SELECCIÓN DE CARACTERÍSTICAS                    ## 
######################################################################

# Métodos de FSelector
source("fSelector-cfs.R")
source("fSelector-chiSquared.R")
source("fSelector-consistency.R")