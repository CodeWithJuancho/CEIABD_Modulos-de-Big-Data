# ANALISIS DE 1000 TIRADAS SIMULADAS ----
# Abran ruleta.Rproj antes de ejecutar este archivo en RStudio.
# No necesita instalar paquetes. Los datos originales no se modifican.
# Las frecuencias describen el historial. No predicen la proxima tirada.

# 1. Configuracion ----
archivo_entrada <- file.path("datos", "ruleta_1000.csv")
carpeta_resultados <- "resultados"
ultimas_x <- 100L  # Cambien solo este valor para analizar las ultimas X tiradas.

# 2. Leer el CSV y comprobar su estructura ----
if (!file.exists(archivo_entrada)) {
  stop("No se encuentra el CSV. Abran ruleta.Rproj y mantengan la carpeta datos junto a los scripts.")
}
datos <- read.csv2(archivo_entrada, fileEncoding = "UTF-8",
                   stringsAsFactors = FALSE)

if (!identical(names(datos), c("tirada", "numero"))) {
  stop("El CSV debe contener exactamente las columnas tirada y numero.")
}
if (nrow(datos) == 0L || anyNA(datos)) {
  stop("El archivo esta vacio o tiene datos ausentes. Revisen el origen sin sustituirlos por cero.")
}
if (!is.numeric(datos$tirada) || !is.numeric(datos$numero)) {
  stop("Las columnas tirada y numero deben ser numericas.")
}
if (any(!is.finite(datos$tirada)) || any(!is.finite(datos$numero))) {
  stop("Se han encontrado valores numericos no finitos.")
}
if (any(datos$numero != floor(datos$numero)) ||
    any(datos$numero < 0 | datos$numero > 36)) {
  stop("Los resultados deben ser numeros enteros entre 0 y 36.")
}
if (any(datos$tirada < 1 | datos$tirada != floor(datos$tirada)) ||
    anyDuplicated(datos$tirada) > 0L) {
  stop("Los identificadores de tirada deben ser enteros positivos y no repetidos.")
}

# El orden de las filas determina que significa 'las ultimas'.
datos <- datos[order(datos$tirada), ]
total <- nrow(datos)
if (length(ultimas_x) != 1L || !is.numeric(ultimas_x) ||
    is.na(ultimas_x) || !is.finite(ultimas_x) ||
    ultimas_x < 1 || ultimas_x != floor(ultimas_x) || ultimas_x > total) {
  stop("ultimas_x debe ser un entero entre 1 y el numero de tiradas disponibles.")
}

dir.create(carpeta_resultados, showWarnings = FALSE)
cat("Tiradas leidas:", total, "\n")
print(head(datos))

# 3. Crear color, paridad y docena ----
# Estas etiquetas se calculan desde numero, no se eligen al azar.
rojos <- c(1, 3, 5, 7, 9, 12, 14, 16, 18,
           19, 21, 23, 25, 27, 30, 32, 34, 36)

datos$color <- ifelse(datos$numero == 0, "Verde",
                      ifelse(datos$numero %in% rojos, "Rojo", "Negro"))

# Cero se conserva aparte en la agrupacion de paridad de la ruleta.
datos$paridad <- ifelse(datos$numero == 0, "Cero",
                        ifelse(datos$numero %% 2 == 0, "Par", "Impar"))

datos$docena <- ifelse(datos$numero == 0, "Cero",
                       ifelse(datos$numero <= 12, "1 a 12",
                              ifelse(datos$numero <= 24, "13 a 24", "25 a 36")))

# 4. Definir una funcion para resumir cualquier grupo de resultados ----
resumir <- function(valores, categorias, probabilidades_modelo) {
  # factor conserva incluso categorias que no aparecen en la muestra.
  frecuencia <- as.integer(table(factor(valores, levels = categorias)))
  n <- length(valores)

  resumen <- data.frame(
    resultado = as.character(categorias),
    frecuencia = frecuencia,
    proporcion_observada = frecuencia / n,
    probabilidad_modelo = probabilidades_modelo
  )
  resumen$porcentaje_observado <- 100 * resumen$proporcion_observada
  resumen$porcentaje_modelo <- 100 * resumen$probabilidad_modelo
  resumen$frecuencia_esperada <- n * resumen$probabilidad_modelo
  resumen$diferencia_pp <- resumen$porcentaje_observado - resumen$porcentaje_modelo
  return(resumen)
}

# 5. Obtener los cuatro resumenes de toda la muestra ----
resumen_numeros <- resumir(datos$numero, 0:36, rep(1 / 37, 37))
resumen_colores <- resumir(datos$color, c("Rojo", "Negro", "Verde"),
                           c(18, 18, 1) / 37)
resumen_paridad <- resumir(datos$paridad, c("Par", "Impar", "Cero"),
                           c(18, 18, 1) / 37)
resumen_docenas <- resumir(datos$docena, c("1 a 12", "13 a 24", "25 a 36", "Cero"),
                           c(12, 12, 12, 1) / 37)

# Estos controles verifican calculos; no demuestran que una ruleta sea justa.
stopifnot(sum(resumen_numeros$frecuencia) == total,
          sum(resumen_colores$frecuencia) == total,
          sum(resumen_paridad$frecuencia) == total,
          sum(resumen_docenas$frecuencia) == total,
          abs(sum(resumen_numeros$proporcion_observada) - 1) < 1e-10)

cat("\nRESUMEN POR COLORES\n")
print(resumen_colores, digits = 4, row.names = FALSE)

# Los cinco primeros por frecuencia observada, no por probabilidad futura.
# En caso de empate se ordenan de menor a mayor numero.
orden_frecuencia <- order(-resumen_numeros$frecuencia,
                          as.integer(resumen_numeros$resultado))
mas_frecuentes <- head(resumen_numeros[orden_frecuencia, ], 5)
cat("\nCINCO NUMEROS MAS FRECUENTES EN ESTE HISTORIAL\n")
print(mas_frecuentes, digits = 4, row.names = FALSE)

# 6. Analizar las ultimas X tiradas ----
recientes <- tail(datos, ultimas_x)
resumen_ultimas_x <- resumir(recientes$numero, 0:36, rep(1 / 37, 37))
cat("\nULTIMAS", ultimas_x, "TIRADAS: frecuencias por numero\n")
print(resumen_ultimas_x[, c("resultado", "frecuencia", "porcentaje_observado")],
      digits = 4, row.names = FALSE)

# Comparar ventanas con un denominador distinto en cada una.
ventanas <- c(20L, 100L, 500L, total)
ventanas <- sort(unique(ventanas[ventanas <= total]))
comparacion_ventanas <- data.frame()
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
cat("\nCOMPARACION DE VENTANAS\n")
print(comparacion_ventanas, digits = 4, row.names = FALSE)

# 7. Calcular la frecuencia acumulada de rojo ----
# TRUE se cuenta como 1 y FALSE como 0. El denominador crece en cada paso.
frecuencia_acumulada_rojo <- cumsum(datos$color == "Rojo") / seq_len(total)
evolucion_rojo <- data.frame(
  tirada = datos$tirada,
  proporcion_acumulada_rojo = frecuencia_acumulada_rojo,
  probabilidad_modelo = rep(18 / 37, total)
)

# 8. Guardar tablas de resultados ----
# Cada nueva ejecucion actualiza estos archivos derivados, no el CSV original.
write.csv2(datos, file.path(carpeta_resultados, "datos_enriquecidos.csv"), row.names = FALSE)
write.csv2(resumen_numeros, file.path(carpeta_resultados, "resumen_numeros.csv"), row.names = FALSE)
write.csv2(resumen_colores, file.path(carpeta_resultados, "resumen_colores.csv"), row.names = FALSE)
write.csv2(resumen_paridad, file.path(carpeta_resultados, "resumen_paridad.csv"), row.names = FALSE)
write.csv2(resumen_docenas, file.path(carpeta_resultados, "resumen_docenas.csv"), row.names = FALSE)
write.csv2(resumen_ultimas_x, file.path(carpeta_resultados, "resumen_ultimas_x.csv"), row.names = FALSE)
write.csv2(comparacion_ventanas, file.path(carpeta_resultados, "comparacion_ventanas.csv"), row.names = FALSE)
write.csv2(evolucion_rojo, file.path(carpeta_resultados, "evolucion_rojo.csv"), row.names = FALSE)

# 9. Grafico de frecuencias por numero ----
colores_numeros <- ifelse(0:36 == 0, "#168067",
                          ifelse(0:36 %in% rojos, "#BA3A43", "#303A46"))
png(file.path(carpeta_resultados, "01_frecuencias_numeros.png"),
    width = 1500, height = 850, res = 140)
barplot(resumen_numeros$frecuencia, names.arg = 0:36, col = colores_numeros,
        border = NA, las = 2, cex.names = 0.8,
        main = paste("Frecuencias por numero en", total, "tiradas"),
        xlab = "Numero", ylab = "Veces que aparece")
abline(h = total / 37, col = "#2066A8", lty = 2, lwd = 2)
legend("topright", legend = "Frecuencia esperada por numero", col = "#2066A8",
       lty = 2, lwd = 2, bty = "n", cex = 0.85)
dev.off()

# 10. Grafico de porcentajes por color ----
png(file.path(carpeta_resultados, "02_porcentajes_colores.png"),
    width = 1300, height = 850, res = 140)
posiciones <- barplot(resumen_colores$porcentaje_observado,
                      names.arg = resumen_colores$resultado,
                      col = c("#BA3A43", "#303A46", "#168067"), border = NA, las = 1,
                      ylim = c(0, max(65, resumen_colores$porcentaje_observado + 10)),
                      main = "Porcentajes observados y modelo",
                      ylab = "Porcentaje de tiradas")
points(posiciones, resumen_colores$porcentaje_modelo,
       pch = 18, cex = 1.5, col = "#2066A8")
legend("topright", legend = "Modelo teorico", pch = 18,
       col = "#2066A8", bty = "n")
dev.off()

# 11. Grafico de evolucion acumulada ----
png(file.path(carpeta_resultados, "03_evolucion_rojo.png"),
    width = 1400, height = 850, res = 140)
plot(seq_len(total), 100 * frecuencia_acumulada_rojo, type = "l", lwd = 2,
     col = "#BA3A43", ylim = c(0, 100), las = 1,
     main = "Evolucion del porcentaje acumulado de rojo",
     xlab = "Tiradas acumuladas", ylab = "Porcentaje acumulado")
abline(h = 100 * 18 / 37, col = "#2066A8", lty = 2, lwd = 2)
legend("topright", legend = c("Observado", "Modelo 18/37"),
       col = c("#BA3A43", "#2066A8"), lty = c(1, 2), lwd = 2, bty = "n")
dev.off()

# 12. Cerrar con una interpretacion correcta ----
cat("\nResultados guardados en:", carpeta_resultados, "\n")
cat("El historial describe lo ocurrido; no cambia por si solo la siguiente tirada.\n")
cat("En el modelo justo e independiente: cada numero tiene probabilidad 1/37,\n")
cat("rojo y negro 18/37 cada uno, y cero 1/37.\n")
cat("Una frecuencia cero en una ventana no implica probabilidad cero.\n")
