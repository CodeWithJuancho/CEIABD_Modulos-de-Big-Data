# Este paquete puede usarse para imputar valores perdidos en
# variables de todo tipo
require(mice)

# carga de datos disponibles directamente en el paquete mice
require(mice)
datos <- airquality

# se fuerzan algunos datos perdidos adicionales
datos[4:10,3] <- rep(NA,7)
datos[1:5,4] <- NA

# se obtiene el patron de aparicion de datos perdidos
patron <- md.pattern(datos)

# se muestra el patron
print(patron)