library(robCompositions)

# carga el conjunto de datos
data(expenditures)

# muestra un valor que se imputara, tras hacerlo NA
otiginal <- expenditures[1,3]
expenditures[1,3] <- NA

# se hace la imputacion
imputacion <- impKNNa(expenditures)

# se muestra el resultado: la entrada xImp del objeto devuelto por
# el metodo de imputacion contiene todos los datos ya imputados
imputado <- imputacion$xImp[1,3]

# se muestran los valores original e imputado
cat("Valor original: ",original, " imputado: ",imputado)


