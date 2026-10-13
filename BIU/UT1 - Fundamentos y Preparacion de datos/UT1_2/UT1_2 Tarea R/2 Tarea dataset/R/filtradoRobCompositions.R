<<<<<<< HEAD
library(robCompositions)

=======
>>>>>>> 34d5046 (Ejercicios mapreduce en proceso)
# carga el conjunto de datos
data(expenditures)

# muestra un valor que se imputara, tras hacerlo NA
<<<<<<< HEAD
otiginal <- expenditures[1,3]
=======
original <- expenditures[1,3]
>>>>>>> 34d5046 (Ejercicios mapreduce en proceso)
expenditures[1,3] <- NA

# se hace la imputacion
imputacion <- impKNNa(expenditures)

# se muestra el resultado: la entrada xImp del objeto devuelto por
# el metodo de imputacion contiene todos los datos ya imputados
imputado <- imputacion$xImp[1,3]

# se muestran los valores original e imputado
cat("Valor original: ",original, " imputado: ",imputado)


