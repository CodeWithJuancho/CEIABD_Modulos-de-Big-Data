# GENERAR EL DATASET DE EJEMPLO ----
# No hace falta ejecutar este archivo para analizar el CSV ya incluido.
# Datos sinteticos: no proceden de un casino ni de una ruleta real.
# Modelo: 37 numeros equiprobables, 0 a 36, y tiradas independientes.
# Requiere R 3.6.0 o posterior. No utiliza paquetes adicionales.

# 1. Parametros de la simulacion ----
semilla <- 2026
numero_tiradas <- 1000L
archivo_salida <- file.path("datos", "ruleta_1000_.csv")

# 2. Proteger el archivo de datos que ya existe ----
if (file.exists(archivo_salida)) {
  stop("El CSV ya existe y no se ha modificado. Para otra simulacion, cambien archivo_salida.")
}
dir.create("datos", showWarnings = FALSE)

# 3. Fijar la semilla y los generadores para repetir el ejemplo ----
set.seed(semilla, kind = "Mersenne-Twister", normal.kind = "Inversion",
         sample.kind = "Rejection")

# 4. Simular resultados con reposicion ----
# Cada numero puede repetirse y todos conservan el mismo peso.
numeros <- sample(0:36, size = numero_tiradas, replace = TRUE)

# 5. Crear una fila por tirada, en orden cronologico ----
tiradas <- data.frame(tirada = seq_len(numero_tiradas), numero = numeros)

# 6. Guardar sin una columna artificial de numeros de fila ----
# write.csv2 usa punto y coma como separador y coma decimal.
write.csv2(tiradas, archivo_salida, row.names = FALSE, fileEncoding = "UTF-8")
cat("Dataset sintetico creado:", archivo_salida, "\n")
cat("Tiradas:", nrow(tiradas), "\n")
print(head(tiradas))
