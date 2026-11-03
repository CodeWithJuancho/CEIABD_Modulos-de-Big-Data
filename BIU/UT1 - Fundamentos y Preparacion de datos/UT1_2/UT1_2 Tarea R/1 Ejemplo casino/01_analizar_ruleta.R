# ANÁLISIS DE UNA RULETA EUROPEA: NÚMEROS DEL 0 AL 36 ----
# Abran ruleta.Rproj. Ejecuten este archivo completo o sus bloques en orden.
# Las tablas aparecen en Console y los gráficos en Plots de RStudio.
# No necesita paquetes adicionales ni guarda archivos de resultados.

# 1. Leer los datos ----
archivo_entrada <- file.path("datos", "ruleta_1000.csv")
ultimas_x <- 100  # Cambien este número para elegir las últimas X tiradas.

if (!file.exists(archivo_entrada)) {
  stop("No se encuentra el CSV. Abran ruleta.Rproj y comprueben la carpeta datos.")
}

# read.csv2() lee el CSV de este ejercicio, separado por punto y coma.
datos <- read.csv2(archivo_entrada, fileEncoding = "UTF-8",
                   stringsAsFactors = FALSE)

# Comprobar los datos antes de calcular evita resultados engañosos.
if (!identical(names(datos), c("tirada", "numero"))) {
  stop("El CSV debe tener exactamente las columnas tirada y numero.")
}
if (nrow(datos) == 0 || anyNA(datos)) {
  stop("El archivo está vacío o tiene valores ausentes.")
}
if (!is.numeric(datos$tirada) || !is.numeric(datos$numero)) {
  stop("Las dos columnas deben ser numéricas.")
}
if (any(!is.finite(datos$tirada)) || any(!is.finite(datos$numero))) {
  stop("Hay valores numéricos no finitos.")
}
if (any(datos$numero != floor(datos$numero)) ||
    any(datos$numero < 0 | datos$numero > 36)) {
  stop("Los resultados deben ser enteros entre 0 y 36.")
}
if (any(datos$tirada < 1 | datos$tirada != floor(datos$tirada)) ||
    anyDuplicated(datos$tirada) > 0) {
  stop("Las tiradas deben tener identificadores enteros, positivos y únicos.")
}

# El historial se ordena por tirada antes de buscar las últimas.
datos <- datos[order(datos$tirada), ]
total <- nrow(datos)
if (length(ultimas_x) != 1 || !is.numeric(ultimas_x) ||
    is.na(ultimas_x) || !is.finite(ultimas_x) ||
    ultimas_x < 1 || ultimas_x != floor(ultimas_x) || ultimas_x > total) {
  stop("ultimas_x debe ser un entero entre 1 y el total de tiradas.")
}
cat("Tiradas leídas:", total, "\n")

# 2. Añadir color, paridad y docena ----
# $ accede a una columna; ifelse(condición, valor_si_se_cumple, valor_si_no).
rojos <- c(1, 3, 5, 7, 9, 12, 14, 16, 18,
           19, 21, 23, 25, 27, 30, 32, 34, 36)

# %in% comprueba si el número está en la lista de rojos.
datos$color <- ifelse(datos$numero == 0, "Verde",
                      ifelse(datos$numero %in% rojos, "Rojo", "Negro"))

# %% devuelve el resto de una división. En la ruleta, el cero va aparte.
datos$paridad <- ifelse(datos$numero == 0, "Cero",
                        ifelse(datos$numero %% 2 == 0, "Par", "Impar"))
datos$docena <- ifelse(datos$numero == 0, "Cero",
                       ifelse(datos$numero <= 12, "1 a 12",
                              ifelse(datos$numero <= 24, "13 a 24", "25 a 36")))

# 3. Preparar una función para no repetir los mismos cálculos ----
resumir <- function(valores, categorias, probabilidades_modelo) {
  # table() cuenta. factor() conserva también las categorías con cero apariciones.
  frecuencia <- as.integer(table(factor(valores, levels = categorias)))
  n <- length(valores)
  proporcion <- frecuencia / n
  
  data.frame(
    resultado = as.character(categorias),
    frecuencia = frecuencia,
    proporcion_observada = proporcion,
    probabilidad_modelo = probabilidades_modelo,
    porcentaje_observado = 100 * proporcion,
    porcentaje_modelo = 100 * probabilidades_modelo,
    frecuencia_esperada = n * probabilidades_modelo,
    diferencia_pp = 100 * proporcion - 100 * probabilidades_modelo
  )
}
# diferencia_pp compara porcentajes: 50 % − 48,65 % = 1,35 puntos porcentuales.

# 4. Resumir todo el historial ----
# En el modelo justo hay 37 números, 18 rojos, 18 negros y un cero verde.
resumen_numeros <- resumir(datos$numero, 0:36, rep(1 / 37, 37))
resumen_colores <- resumir(datos$color, c("Rojo", "Negro", "Verde"), c(18, 18, 1) / 37)
resumen_paridad <- resumir(datos$paridad, c("Par", "Impar", "Cero"), c(18, 18, 1) / 37)
resumen_docenas <- resumir(datos$docena, c("1 a 12", "13 a 24", "25 a 36", "Cero"),
                           c(12, 12, 12, 1) / 37)

# stopifnot() detiene el código si una comprobación de los cálculos falla.
stopifnot(sum(resumen_numeros$frecuencia) == total,
          sum(resumen_colores$frecuencia) == total,
          sum(resumen_paridad$frecuencia) == total,
          sum(resumen_docenas$frecuencia) == total,
          abs(sum(resumen_numeros$proporcion_observada) - 1) < 1e-10)

# Orden descendente de frecuencia; los empates se ordenan por número.
orden_frecuencia <- order(-resumen_numeros$frecuencia,
                          as.integer(resumen_numeros$resultado))
mas_frecuentes <- head(resumen_numeros[orden_frecuencia, ], 5)

# 5. Comparar las últimas tiradas ----
# tail() selecciona las últimas filas de una tabla.
recientes <- tail(datos, ultimas_x)
resumen_ultimas_x <- resumir(recientes$numero, 0:36, rep(1 / 37, 37))

ventanas <- c(20, 100, 500, total)
ventanas <- sort(unique(ventanas[ventanas <= total]))
comparacion_ventanas <- data.frame()

# El bucle repite el cálculo con cada tamaño de ventana disponible.
for (tamano in ventanas) {
  tramo <- tail(datos, tamano)
  fila <- data.frame(
    ultimas_tiradas = tamano,
    rojos = sum(tramo$color == "Rojo"),
    negros = sum(tramo$color == "Negro"),
    ceros = sum(tramo$color == "Verde")
  )
  fila$porcentaje_rojo <- 100 * fila$rojos / tamano
  fila$porcentaje_rojo_modelo <- 100 * 18 / 37
  comparacion_ventanas <- rbind(comparacion_ventanas, fila)
}

# 6. Calcular la evolución acumulada del rojo ----
# cumsum() acumula los rojos: TRUE cuenta como 1 y FALSE como 0.
# seq_len(total) genera 1, 2, 3... para dividir por las tiradas acumuladas.
frecuencia_acumulada_rojo <- cumsum(datos$color == "Rojo") / seq_len(total)
evolucion_rojo <- data.frame(
  tirada = datos$tirada,
  proporcion_acumulada_rojo = frecuencia_acumulada_rojo,
  probabilidad_modelo = rep(18 / 37, total)
)

# 7. Mostrar los resúmenes en la consola ----
mostrar <- function(titulo, tabla) {
  cat("\n", titulo, "\n", sep = "")
  # max evita que R oculte filas de los resúmenes.
  print(tabla, row.names = FALSE, digits = 4, max = nrow(tabla) * ncol(tabla))
}

mostrar("RESUMEN POR NÚMEROS", resumen_numeros)
mostrar("RESUMEN POR COLORES", resumen_colores)
mostrar("RESUMEN POR PARIDAD", resumen_paridad)
mostrar("RESUMEN POR DOCENAS", resumen_docenas)
mostrar("CINCO NÚMEROS MÁS FRECUENTES EN EL HISTORIAL", mas_frecuentes)
mostrar(paste("ÚLTIMAS", ultimas_x, "TIRADAS: RESUMEN POR NÚMEROS"), resumen_ultimas_x)
mostrar("COMPARACIÓN DE VENTANAS", comparacion_ventanas)

# 8. Gráfico de frecuencias por número ----
# Los siete gráficos aparecen en Plots. Usen sus flechas para volver a los anteriores.
par(mfrow = c(1, 1))
colores_numeros <- ifelse(0:36 == 0, "darkgreen",
                          ifelse(0:36 %in% rojos, "firebrick", "grey20"))
barplot(resumen_numeros$frecuencia, names.arg = 0:36, col = colores_numeros,
        border = NA, las = 2, cex.names = 0.8,
        main = paste("Frecuencias por número en", total, "tiradas"),
        xlab = "Número", ylab = "Veces que aparece")
# La línea indica lo esperado en promedio: total de tiradas dividido entre 37.
abline(h = total / 37, col = "steelblue", lty = 2, lwd = 2)
legend("topright", legend = "Frecuencia esperada por número", col = "steelblue",
       lty = 2, lwd = 2, bty = "n", cex = 0.85)

# 9. Gráfico de porcentajes por color ----
# La misma función sirve para color, paridad y docenas.
graficar_porcentajes <- function(tabla, titulo, colores) {
  posiciones <- barplot(tabla$porcentaje_observado,
                        names.arg = tabla$resultado, col = colores,
                        border = NA, las = 1,
                        ylim = c(0, max(70, tabla$porcentaje_observado + 25,
                                        tabla$porcentaje_modelo + 25)),
                        main = titulo, ylab = "Porcentaje de tiradas")
  
  # Barras y etiquetas: datos observados. Rombos: probabilidades del modelo.
  points(posiciones, tabla$porcentaje_modelo, pch = 18, cex = 1.5, col = "steelblue")
  etiquetas <- paste0(round(tabla$porcentaje_observado, 1), " %\n",
                      tabla$frecuencia, " tiradas")
  text(posiciones, pmax(tabla$porcentaje_observado, tabla$porcentaje_modelo) + 7,
       labels = etiquetas, cex = 0.85)
  legend("topright", legend = "Modelo teórico", pch = 18,
         col = "steelblue", bty = "n", cex = 0.85)
}

graficar_porcentajes(resumen_colores, "Resultados por color",
                     c("firebrick", "grey20", "darkgreen"))

# 10. Gráfico de pares e impares ----
# El cero tiene su propia categoría y una probabilidad del modelo de 1/37.
graficar_porcentajes(resumen_paridad, "Resultados por paridad",
                     c("darkcyan", "darkorange", "darkgreen"))

# 11. Gráfico de docenas ----
graficar_porcentajes(resumen_docenas, "Resultados por docena",
                     c("darkcyan", "darkorange", "mediumpurple", "darkgreen"))

# 12. Gráfico de los cinco números más frecuentes ----
posiciones <- barplot(mas_frecuentes$frecuencia,
                      names.arg = mas_frecuentes$resultado, col = "darkcyan",
                      border = NA, las = 1,
                      ylim = c(0, max(mas_frecuentes$frecuencia, total / 37) + 15),
                      main = "Cinco números más frecuentes del historial",
                      xlab = "Número", ylab = "Veces que aparece")
text(posiciones, mas_frecuentes$frecuencia + 3,
     labels = mas_frecuentes$frecuencia)
abline(h = total / 37, col = "steelblue", lty = 2, lwd = 2)
legend("topright", legend = "Esperada para cualquier número",
       col = "steelblue", lty = 2, lwd = 2, bty = "n", cex = 0.8)
# Este ranking describe el historial; no indica números con más probabilidad futura.

# 13. Gráfico de comparación de ventanas ----
# Cada porcentaje divide los rojos entre las tiradas de ESA ventana.
posiciones <- barplot(comparacion_ventanas$porcentaje_rojo,
                      names.arg = comparacion_ventanas$ultimas_tiradas,
                      col = "firebrick", border = NA, las = 1,
                      ylim = c(0, max(70, comparacion_ventanas$porcentaje_rojo + 25)),
                      main = "Rojo en las últimas tiradas",
                      xlab = "Tamaño de la ventana", ylab = "Porcentaje de rojo")
text(posiciones, comparacion_ventanas$porcentaje_rojo + 7,
     labels = paste0(round(comparacion_ventanas$porcentaje_rojo, 1), " %\n",
                     comparacion_ventanas$rojos, " rojos"), cex = 0.85)
abline(h = 100 * 18 / 37, col = "steelblue", lty = 2, lwd = 2)
legend("topright", legend = "Modelo 18/37", col = "steelblue",
       lty = 2, lwd = 2, bty = "n", cex = 0.85)
# Las ventanas se solapan: pertenecen al mismo historial.

# 14. Gráfico de evolución acumulada ----
plot(seq_len(total), 100 * frecuencia_acumulada_rojo, type = "l", lwd = 2,
     col = "firebrick", ylim = c(0, 100), las = 1,
     main = "Evolución del porcentaje acumulado de rojo",
     xlab = "Tiradas acumuladas", ylab = "Porcentaje acumulado")
abline(h = 100 * 18 / 37, col = "steelblue", lty = 2, lwd = 2)
legend("topright", legend = c("Observado", "Modelo 18/37"),
       col = c("firebrick", "steelblue"), lty = c(1, 2), lwd = 2, bty = "n")

cat("\nINTERPRETACIÓN\n")
cat("Las frecuencias describen el historial; no predicen la próxima tirada.\n")
cat("En el modelo justo e independiente: cada número tiene probabilidad 1/37;\n")
cat("rojo y negro, 18/37 cada uno; el cero, 1/37.\n")
cat("Que un número no aparezca en una ventana no significa que su probabilidad sea cero.\n")
