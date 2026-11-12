require(discretization)
require(mice)

# se usa el conjunto de datos de calidad del aire, en las
# mismas condiciones que vimos con anterioridad
data(iris)
# discretizacion mediante metodo CAIM
datosdiscretos_cm <- disc.Topdown(iris, method=1)

# se muestran los puntos de corte
cat("Puntos de corte metodo CAIM: \n")
print(datosdiscretos_cm$cutp)

# los datos discretizados se mostrarian de la
# forma siguiente
# cat("Datos discretizados: \n")
# print(cm$Disc.data)

# discretizacion mediante CACC
datosdiscretos_cmCacc <- disc.Topdown(iris, method=2)

# se muestran los puntos de corte
cat("Puntos de corte metodo CACC: \n")
print(datosdiscretos_cmCacc$cutp)

# discretizacion mediante AMEVA
datosdiscretos_cmAmeva <- disc.Topdown(iris, method=3)

# se muestran los puntos de corte
cat("Puntos de corte metodo AMEVA: \n")
print(datosdiscretos_cmAmeva$cutp)

