<<<<<<< HEAD
<<<<<<< HEAD
library(robCompositions)

=======
>>>>>>> 34d5046 (Ejercicios mapreduce en proceso)
=======
>>>>>>> origin/alumno/DanielGlez
# carga el conjunto de datos
data(expenditures)

# muestra un valor que se imputara, tras hacerlo NA
<<<<<<< HEAD
<<<<<<< HEAD
otiginal <- expenditures[1,3]
=======
original <- expenditures[1,3]
>>>>>>> 34d5046 (Ejercicios mapreduce en proceso)
=======
original <- expenditures[1,3]
>>>>>>> origin/alumno/DanielGlez
expenditures[1,3] <- NA

# se hace la imputacion
imputacion <- impKNNa(expenditures)

# se muestra el resultado: la entrada xImp del objeto devuelto por
# el metodo de imputacion contiene todos los datos ya imputados
imputado <- imputacion$xImp[1,3]

# se muestran los valores original e imputado
cat("Valor original: ",original, " imputado: ",imputado)


