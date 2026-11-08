# Análisis de una ruleta en RStudio

## Qué van a obtener

Un análisis resuelto de **1.000 tiradas simuladas** de una ruleta con 37 resultados, del 0 al 36. Se calcula qué ocurrió en la muestra completa y en las últimas X tiradas, se compara con las probabilidades del modelo y se generan tres gráficos.

El proyecto utiliza **R básico, sin instalar paquetes**. Los scripts están comentados y esta guía explica todos sus bloques. El CSV ya está generado y los resultados de ejemplo también están incluidos.

**Las cifras son sintéticas, no proceden de un casino.** El modelo supone números equiprobables y tiradas independientes. El proyecto describe el historial; no recomienda apuestas ni predice la siguiente tirada.

## 1 Abrir y ejecutar en RStudio

1. Descompriman el ZIP completo. No ejecuten los archivos desde el interior del ZIP.
2. Abran `ruleta.Rproj` con RStudio. Mantengan las carpetas y los scripts juntos.
3. Abran `01_analizar_ruleta.R`.
4. Pulsen **Source** en el editor para ejecutar todo el archivo. No necesitan ejecutar antes el generador: el CSV ya viene incluido.
5. Revisen los resultados impresos en **Console** y los objetos creados en **Environment**.
6. En **Files**, abran la carpeta `resultados` para consultar los CSV y las imágenes PNG.

También pueden ejecutar, en la consola del proyecto:

```r
source("01_analizar_ruleta.R", encoding = "UTF-8")
```

Para trabajar por partes, seleccionen un bloque del script y pulsen **Run**. Deben mantener el orden, porque los bloques posteriores utilizan objetos creados antes.

Los gráficos se guardan directamente en archivos PNG. Por eso no es necesario que aparezcan en el panel **Plots**. Los mensajes `null device 1` que puedan ver al cerrar cada imagen son normales: no indican un error.

La configuración del proyecto evita restaurar automáticamente un espacio de trabajo guardado. Para repetir una prueba desde cero pueden reiniciar la sesión de R y volver a ejecutar el script completo.

## 2 Los archivos del proyecto

```text
miniproyecto-ruleta-rstudio/
├── ruleta.Rproj
├── 00_generar_datos.R
├── 01_analizar_ruleta.R
├── GUIA_COMPLETA.md
├── datos/
│   └── ruleta_1000.csv
└── resultados/
    ├── datos_enriquecidos.csv
    ├── resumen_numeros.csv
    ├── resumen_colores.csv
    ├── resumen_paridad.csv
    ├── resumen_docenas.csv
    ├── resumen_ultimas_x.csv
    ├── comparacion_ventanas.csv
    ├── evolucion_rojo.csv
    ├── 01_frecuencias_numeros.png
    ├── 02_porcentajes_colores.png
    └── 03_evolucion_rojo.png
```

`00_generar_datos.R` permite reproducir la simulación. `01_analizar_ruleta.R` lee el CSV y lo analiza sin modificarlo. Cada ejecución actualiza las tablas y los gráficos de `resultados`.

El dataset original tiene dos columnas:

| Columna | Significado |
| --- | --- |
| `tirada` | Posición de la tirada en el historial: del 1 al 1000. |
| `numero` | Resultado de esa tirada: un entero del 0 al 36. |

Sus primeras filas son:

```text
tirada;numero
1;28
2;32
3;26
4;35
5;4
6;30
```

Cada fila es una tirada. **Dos resultados iguales no son filas duplicadas**: el mismo número puede aparecer en tiradas distintas. Lo que no debe repetirse es el identificador `tirada`.

El separador es punto y coma. Los números decimales de los archivos de resultados utilizan coma. Por eso se leen con `read.csv2`, no con `read.csv` con sus valores predeterminados.

## 3 La diferencia entre probabilidad y frecuencia

El modelo tiene 37 números con la misma probabilidad:

```r
1 / 37
100 * 1 / 37
```

El primer cálculo devuelve aproximadamente `0.02702703`, una probabilidad expresada entre 0 y 1. El segundo devuelve aproximadamente `2.702703`, el mismo valor expresado en porcentaje.

Para este modelo:

| Resultado o grupo | Probabilidad | Porcentaje aproximado |
| --- | --- | --- |
| Un número concreto | 1/37 | 2,7027 % |
| Rojo | 18/37 | 48,6486 % |
| Negro | 18/37 | 48,6486 % |
| Cero | 1/37 | 2,7027 % |
| Par, sin incluir el cero | 18/37 | 48,6486 % |
| Impar | 18/37 | 48,6486 % |
| Una docena concreta | 12/37 | 32,4324 % |

La **frecuencia absoluta** cuenta cuántas veces ocurrió algo. La **frecuencia relativa o proporción observada** divide esa cantidad entre el número de tiradas analizadas.

En el CSV, el 17 aparece 43 veces:

```r
43 / 1000       # 0.043
100 * 43 / 1000 # 4.3 por ciento
```

Eso describe esta muestra. Bajo el modelo justo e independiente, la siguiente tirada sigue asignando `1/37` al 17. Ni el 4,3 % observado ni una racha demuestran que ese número haya adquirido una probabilidad mayor.

Las frecuencias pueden utilizarse como estimaciones de una distribución desconocida bajo supuestos adecuados. En este ejercicio conocemos el modelo porque nosotros generamos los datos. No estamos demostrando que una ruleta real sea justa.

## 5 El generador explicado por completo

Este es el contenido esencial de `00_generar_datos.R`. La versión descargable incluye los comentarios y la protección del archivo original.

### Parámetros y protección del CSV

```r
semilla <- 2026
numero_tiradas <- 1000L
archivo_salida <- file.path("datos", "ruleta_1000.csv")
```

`semilla` identifica el punto de partida del generador pseudoaleatorio. `numero_tiradas` indica cuántos resultados se crean. `file.path` construye una ruta relativa de forma compatible con distintos sistemas operativos.

Antes de generar datos, el script utiliza `file.exists` para comprobar si ya existe ese CSV. Si existe, `stop` detiene la ejecución con un mensaje. Esto impide sobrescribirlo por accidente. `dir.create` crea la carpeta `datos`; `showWarnings = FALSE` evita un aviso innecesario si ya existe.

**El generador se detendrá en el proyecto entregado porque el CSV ya está incluido. Es intencionado.** Para generar otra muestra, cambien primero `archivo_salida`, por ejemplo a `ruleta_otro_ejemplo.csv`. Para analizarla, cambien también `archivo_entrada` en el analizador.

### Semilla y simulación

```r
set.seed(semilla, kind = "Mersenne-Twister", normal.kind = "Inversion",
         sample.kind = "Rejection")
numeros <- sample(0:36, size = numero_tiradas, replace = TRUE)
```

`set.seed` permite repetir la misma secuencia. Además de la semilla, se fijan explícitamente las opciones de generación para que el ejemplo sea reproducible con versiones modernas de R. `normal.kind` especifica el método de generación normal, aunque aquí no se generan variables normales. No necesitan conocer esos algoritmos para seguir la práctica.

`sample` elige elementos del vector `0:36`. `size` pide 1000 elecciones. `replace = TRUE` permite volver a elegir un número ya utilizado. Es fundamental: una tirada no elimina ese número de las siguientes. Al no especificar pesos diferentes en `prob`, todos los elementos tienen el mismo peso.

**No se ha obligado a que cada número aparezca la misma cantidad de veces.** Se han realizado elecciones pseudoaleatorias con los mismos pesos y con reposición. La semilla no descubre ni reproduce resultados de un casino real.

### Tabla y exportación

```r
tiradas <- data.frame(tirada = seq_len(numero_tiradas), numero = numeros)
write.csv2(tiradas, archivo_salida, row.names = FALSE, fileEncoding = "UTF-8")
```

`data.frame` reúne columnas en una tabla. `seq_len(1000)` produce los identificadores del 1 al 1000. `numeros` aporta los resultados en el mismo orden.

`write.csv2` escribe el archivo con separador punto y coma. `row.names = FALSE` evita añadir una columna artificial con números de fila. `fileEncoding` fija la codificación de texto.

Finalmente, `cat` muestra mensajes de texto, `nrow` cuenta filas y `print(head(tiradas))` enseña las primeras seis tiradas. `\n` es un salto de línea.

## 6 Analizador bloque 1 Configuración

```r
archivo_entrada <- file.path("datos", "ruleta_1000.csv")
carpeta_resultados <- "resultados"
ultimas_x <- 100L
```

El primer objeto indica qué archivo se lee. El segundo indica dónde se guardan las salidas. `ultimas_x` permite elegir cuántas tiradas recientes se estudian. No cambia el análisis de la muestra completa ni modifica el CSV.

Al abrir el proyecto, las rutas se interpretan desde su carpeta. El script no contiene rutas personales ni llama a otros scripts. No necesita objetos guardados de una sesión anterior.

## 7 Analizador bloque 2 Lectura y comprobaciones

```r
datos <- read.csv2(archivo_entrada, fileEncoding = "UTF-8",
                   stringsAsFactors = FALSE)
```

`read.csv2` transforma el archivo en una tabla de R. `stringsAsFactors = FALSE` evita convertir automáticamente textos en factores. Las columnas originales deben reconocerse como numéricas.

El código valida el archivo antes de calcular resultados:

| Comprobación | Qué evita |
| --- | --- |
| `file.exists` | Intentar leer una ruta que no existe. |
| `identical(names(datos), c("tirada", "numero"))` | Leer columnas distintas, mal separadas o con nombres inesperados. |
| `nrow(datos) == 0L` | Trabajar con una tabla sin tiradas. |
| `anyNA(datos)` | Ignorar silenciosamente datos ausentes. |
| `is.numeric` | Hacer cuentas con columnas importadas como texto. |
| `is.finite` | Aceptar valores como infinito. |
| `numero != floor(numero)` | Aceptar un resultado decimal, por ejemplo 7,5. |
| `numero < 0 \| numero > 36` | Aceptar números fuera del modelo. |
| `anyDuplicated(datos$tirada)` | Repetir el identificador de una tirada. |

`any` pregunta si se cumple una condición en algún elemento. `floor` devuelve el entero inferior: si un valor es igual a su `floor`, no tiene parte decimal. `stop` interrumpe el análisis cuando se incumple una condición.

**No se sustituyen datos ausentes por cero.** Cero es un resultado válido de la ruleta, no un código para representar una ausencia.

```r
datos <- datos[order(datos$tirada), ]
total <- nrow(datos)
```

`order` devuelve las posiciones necesarias para ordenar por `tirada`. Los corchetes reorganizan filas y conservan todas las columnas. No se ordena por `numero`, porque eso destruiría el significado de «últimas tiradas».

El código comprueba también que `ultimas_x` sea un único número entero, finito y situado entre 1 y `total`. Así evita analizar una ventana vacía o pedir más registros de los que existen.

La carpeta de salida se crea con `dir.create`. `head` muestra un pequeño ejemplo para comprobar visualmente la lectura. El dataset entregado tiene identificadores consecutivos. Si utilizaran otro archivo con huecos, «últimas X» significaría los últimos X registros disponibles, no demostraría que no faltan tiradas intermedias.

## 8 Analizador bloque 3 Crear los grupos

### Color

```r
rojos <- c(1, 3, 5, 7, 9, 12, 14, 16, 18,
           19, 21, 23, 25, 27, 30, 32, 34, 36)
datos$color <- ifelse(datos$numero == 0, "Verde",
                      ifelse(datos$numero %in% rojos, "Rojo", "Negro"))
```

`rojos` contiene los 18 números que etiquetamos como rojos en el modelo. Los otros 18 números del 1 al 36 son negros; el cero es verde.

`ifelse(condicion, valor_si_se_cumple, valor_si_no)` aplica una decisión a cada elemento. Primero se separa el cero; después `%in%` comprueba si el número pertenece al vector de rojos. La nueva columna `color` se incorpora al objeto `datos` en memoria. El CSV original sigue intacto.

### Paridad

```r
datos$paridad <- ifelse(datos$numero == 0, "Cero",
                        ifelse(datos$numero %% 2 == 0, "Par", "Impar"))
```

El resto de dividir un entero par entre 2 es cero. `%% 2 == 0` detecta esa condición. **Matemáticamente, cero es par**, pero en esta agrupación de la ruleta se conserva aparte para no incluirlo dentro del grupo de 18 números pares del 1 al 36.

### Docena

```r
datos$docena <- ifelse(datos$numero == 0, "Cero",
                       ifelse(datos$numero <= 12, "1 a 12",
                              ifelse(datos$numero <= 24, "13 a 24", "25 a 36")))
```

Se comprueban los límites en orden. Después de excluir cero, un número hasta 12 pertenece a la primera docena. Si no cumplió esa condición y es como máximo 24, pertenece a la segunda. El resto pertenece a la tercera.

## 9 Analizador bloque 4 La función resumir

Esta función evita repetir el mismo cálculo para números, colores, paridad y docenas:

```r
resumir <- function(valores, categorias, probabilidades_modelo) {
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
```

`function` define un procedimiento reutilizable. `valores` recibe los resultados a contar, `categorias` enumera todos los resultados posibles y `probabilidades_modelo` aporta las probabilidades teóricas en ese mismo orden. Al llamar a la función se sustituyen estos argumentos por los objetos concretos.

La primera instrucción hace tres cosas:

1. `factor(..., levels = categorias)` fija todas las categorías posibles y su orden.
2. `table` cuenta las apariciones de cada categoría.
3. `as.integer` extrae los conteos como enteros para usarlos en la tabla final.

El factor es importante: si el 23 no aparece en una ventana, queremos conservar su fila con frecuencia cero, no eliminarlo del resumen.

`length(valores)` devuelve cuántas observaciones entran en esa llamada. Para el archivo completo es 1000; para las últimas 100 tiradas es 100. La función utiliza siempre su propio denominador.

`as.character` guarda las etiquetas como texto. Esto permite que la misma columna represente tanto números como palabras. Si más adelante se necesita ordenar esas etiquetas numéricas, se convierten explícitamente con `as.integer`.

Cada columna significa lo siguiente:

| Columna | Cálculo y significado |
| --- | --- |
| `resultado` | Número o grupo que se analiza. |
| `frecuencia` | Cantidad observada en esa muestra. |
| `proporcion_observada` | Frecuencia dividida entre el tamaño de la muestra. |
| `probabilidad_modelo` | Probabilidad fijada por el modelo equiprobable. |
| `porcentaje_observado` | Proporción observada multiplicada por 100. |
| `porcentaje_modelo` | Probabilidad del modelo multiplicada por 100. |
| `frecuencia_esperada` | Tamaño de la muestra multiplicado por la probabilidad del modelo. |
| `diferencia_pp` | Porcentaje observado menos porcentaje del modelo, en puntos porcentuales. |

La frecuencia esperada de cada número en 1000 tiradas es `1000 / 37`, aproximadamente 27,027. Puede tener decimales porque es una expectativa, no una afirmación de que un número tenga que aparecer exactamente esa cantidad de veces.

Para el 17, la diferencia es aproximadamente `4.3 - 2.7027 = 1.5973` **puntos porcentuales**. No se debe confundir con un incremento relativo del 1,5973 %.

`return(resumen)` devuelve la tabla construida. Las variables `n` y `frecuencia` de esta función son locales a la llamada: no hay que crearlas antes en la consola.

## 10 Analizador bloque 5 Resúmenes y clasificación

```r
resumen_numeros <- resumir(datos$numero, 0:36, rep(1 / 37, 37))
resumen_colores <- resumir(datos$color, c("Rojo", "Negro", "Verde"),
                           c(18, 18, 1) / 37)
```

`rep(1 / 37, 37)` crea 37 probabilidades iguales, una para cada número. Para los colores, el vector de probabilidades tiene tres elementos, en el mismo orden que sus etiquetas: 18/37 para rojo, 18/37 para negro y 1/37 para verde.

La paridad utiliza `c(18, 18, 1) / 37`. Las docenas utilizan `c(12, 12, 12, 1) / 37`. R divide cada elemento del vector entre 37. Las etiquetas y probabilidades deben corresponderse en posición.

El bloque de `stopifnot` comprueba que cada tabla cuenta exactamente `total` tiradas y que las proporciones por número suman 1, admitiendo una tolerancia de `1e-10`, es decir, 0,0000000001, por la representación decimal de los ordenadores. `sum` suma elementos y `abs` toma el valor absoluto de una diferencia.

**Estas comprobaciones validan las cuentas, no la justicia ni la independencia de una ruleta real.**

La clasificación se construye así:

```r
orden_frecuencia <- order(-resumen_numeros$frecuencia,
                          as.integer(resumen_numeros$resultado))
mas_frecuentes <- head(resumen_numeros[orden_frecuencia, ], 5)
```

El signo negativo permite ordenar de mayor a menor frecuencia. El segundo criterio desempata por número ascendente. `head(..., 5)` conserva cinco filas. Cuando hay empates puede haber otros números con la misma frecuencia fuera de esas cinco filas.

`print(..., digits = 4, row.names = FALSE)` simplifica la presentación de la consola. `digits` se refiere a cifras significativas, no a cuatro decimales fijos. No redondea ni modifica los valores almacenados o exportados.

## 11 Analizador bloque 6 Las últimas X tiradas

```r
recientes <- tail(datos, ultimas_x)
resumen_ultimas_x <- resumir(recientes$numero, 0:36, rep(1 / 37, 37))
```

`tail` toma las últimas filas de la tabla ya ordenada. Con `ultimas_x <- 100L`, son las tiradas 901 a 1000. La función cuenta solo esas 100 observaciones. Las probabilidades del modelo no cambian al reducir la ventana.

En la impresión se seleccionan tres columnas:

```r
resumen_ultimas_x[, c("resultado", "frecuencia", "porcentaje_observado")]
```

La parte vacía antes de la coma conserva todas las filas. El vector situado después de la coma elige las columnas que se muestran.

### Comparar varias ventanas

```r
ventanas <- c(20L, 100L, 500L, total)
ventanas <- sort(unique(ventanas[ventanas <= total]))
```

Se proponen tamaños de 20, 100, 500 y todas las tiradas. El filtro elimina tamaños superiores a los disponibles. `unique` evita repetir un tamaño y `sort` los ordena de menor a mayor.

`for (tamano in ventanas)` repite las mismas instrucciones para cada tamaño. Dentro del bucle, `tramo <- tail(datos, tamano)` toma los datos correspondientes. Expresiones como `sum(tramo$color == "Rojo")` cuentan los rojos: al sumar, R interpreta `TRUE` como 1 y `FALSE` como 0.

Se crea una fila con los conteos y se calcula el porcentaje rojo dividiendo por **ese tamaño**, no siempre por 1000. `rbind` incorpora la fila a la tabla de comparación. La tabla comienza vacía con `data.frame()`.

Las ventanas se solapan: las últimas 20 están dentro de las últimas 100, y así sucesivamente. No son cuatro experimentos independientes ni permiten atribuir causas a sus diferencias.

## 12 Analizador bloque 7 Evolución acumulada

```r
frecuencia_acumulada_rojo <- cumsum(datos$color == "Rojo") / seq_len(total)
```

La comparación produce un vector de verdaderos y falsos. `cumsum` suma esos indicadores de manera acumulada. `seq_len(total)` crea los denominadores 1, 2, 3, etc. La división se realiza elemento a elemento.

Ejemplo pequeño:

```r
indicadores <- c(TRUE, FALSE, TRUE)
cumsum(indicadores)                # 1, 1, 2
cumsum(indicadores) / seq_len(3)    # 1, 0.5, 0.6666667
```

Después de una tirada hay un rojo de una; después de dos, uno de dos; después de tres, dos de tres. El gráfico muestra qué porcentaje rojo se ha acumulado conforme avanza la muestra.

Con más datos, las fluctuaciones relativas suelen estabilizarse bajo el modelo. **La aproximación no tiene que ser monótona, ni obliga a terminar exactamente en 18/37, ni indica que la ruleta deba compensar las tiradas anteriores.**

`evolucion_rojo` guarda esta información en una tabla de 1000 filas para poder consultarla fuera de R.

## 13 Analizador bloque 8 Exportar las tablas

Cada llamada a `write.csv2` guarda uno de los objetos calculados en un archivo de `resultados`. Por ejemplo:

```r
write.csv2(resumen_numeros,
           file.path(carpeta_resultados, "resumen_numeros.csv"),
           row.names = FALSE)
```

El primer argumento es la tabla a exportar. El segundo construye su ruta. El último evita la columna adicional de números de fila.

Los ocho archivos tienen funciones distintas: datos enriquecidos con sus etiquetas, cuatro resúmenes de toda la muestra, el resumen de las últimas X tiradas, la comparación de ventanas y la evolución acumulada. El CSV de origen se conserva en `datos` y no se escribe sobre él.

Las proporciones se exportan como números, sin añadirles el símbolo `%` dentro de la celda. Los nombres de las columnas indican si el valor es una proporción o un porcentaje. Se conserva la precisión del cálculo; el redondeo de una captura no debe confundirse con un cambio de los datos.

## 14 Analizador bloques 9 a 11 Los gráficos

Los tres gráficos siguen la misma secuencia:

```r
png("ruta_del_grafico.png", width = 1400, height = 850, res = 140)
# Instrucciones que dibujan el grafico.
dev.off()
```

`png` abre un dispositivo gráfico que escribe en una imagen. `width` y `height` indican su tamaño en píxeles y `res` su resolución. `dev.off` cierra ese dispositivo y termina el archivo. No deben omitir ese cierre al ejecutar bloques por separado.

### Gráfico 1 Frecuencias por número

`barplot` dibuja una barra por cada número. La altura es `frecuencia` y `names.arg` coloca las etiquetas 0 a 36. `colores_numeros` asigna verde al cero y los colores correspondientes al resto.

`abline(h = total / 37, ...)` añade una línea horizontal con la frecuencia esperada. `lty = 2` hace la línea discontinua; `lwd = 2` controla su grosor. Que unas barras estén por encima y otras por debajo no demuestra por sí solo un sesgo.

`main` define el título, `xlab` e `ylab` los títulos de los ejes, `border = NA` suprime el borde de las barras y `cex.names` ajusta el tamaño de los nombres. En este gráfico, `las = 2` coloca los números del eje horizontal en vertical para que se vean los 37 sin omisiones. Los otros gráficos utilizan `las = 1` para mantener horizontales las etiquetas. `paste` compone un título que incluye el número real de registros.

### Gráfico 2 Porcentajes por color

Las barras muestran los porcentajes observados. Los rombos azules muestran el modelo. `barplot` devuelve las posiciones de las barras y se guardan en `posiciones`; `points` utiliza esas mismas posiciones para colocar correctamente los rombos.

`pch = 18` elige el rombo y `cex` su tamaño. `ylim` fija el intervalo vertical. Se deja espacio suficiente para que ninguna barra quede cortada, incluso si cambian el archivo de entrada.

### Gráfico 3 Porcentaje acumulado de rojo

`plot(..., type = "l")` dibuja una línea, no puntos aislados. El eje horizontal indica cuántas tiradas se han acumulado; el vertical, el porcentaje de rojos hasta ese momento. La línea discontinua indica `100 * 18 / 37`.

En los tres gráficos, `legend` añade la leyenda; `col` especifica colores; `bty = "n"` elimina el recuadro de la leyenda. Los colores se expresan con códigos hexadecimales, que son simplemente una forma de especificar tonos.

## 15 Analizador bloque 12 Interpretar y cerrar

Los últimos `cat` recuerdan que los resultados describen una muestra y muestran dónde se han guardado las salidas. No hacen una predicción ni transforman el historial en una recomendación.

Con la configuración entregada, estos resultados deben coincidir:

### Muestra completa

| Grupo | Frecuencia | Porcentaje observado |
| --- | --- | --- |
| Rojo | 484 | 48,4 % |
| Negro | 484 | 48,4 % |
| Verde o cero | 32 | 3,2 % |
| Total | 1000 | 100 % |

La igualdad entre 484 rojos y 484 negros es un resultado de esta simulación, no una condición impuesta por el código.

### Cinco primeros por frecuencia observada

| Número | Frecuencia | Porcentaje observado |
| --- | --- | --- |
| 17 | 43 | 4,3 % |
| 35 | 36 | 3,6 % |
| 30 | 34 | 3,4 % |
| 0 | 32 | 3,2 % |
| 1 | 32 | 3,2 % |

El criterio de desempate es número ascendente. La tabla no dice qué cinco números saldrán después ni cuáles tienen más probabilidad en el modelo.

### Ventanas del final del historial

| Últimas tiradas | Rojos | Negros | Ceros | Porcentaje rojo |
| --- | --- | --- | --- | --- |
| 20 | 11 | 8 | 1 | 55,0 % |
| 100 | 50 | 46 | 4 | 50,0 % |
| 500 | 243 | 239 | 18 | 48,6 % |
| 1000 | 484 | 484 | 32 | 48,4 % |

Las últimas 100 tiradas contienen nueve resultados iguales a 32 y ningún 23 ni 28. Eso produce frecuencias del 9 %, 0 % y 0 %, respectivamente. **Bajo el modelo, los tres números mantienen la misma probabilidad 1/37 para la siguiente tirada.** Una frecuencia observada cero no significa imposibilidad.

### Ejemplo de conclusión para la memoria

«Se han analizado 1000 tiradas simuladas. El 17 es el número más frecuente del historial, con 43 apariciones y un 4,3 %. Los rojos y negros representan un 48,4 % cada uno y el cero un 3,2 %. Al reducir la ventana a las últimas 20 tiradas, el porcentaje rojo es del 55 %. Estas cifras describen muestras de distinto tamaño y no modifican las probabilidades del modelo independiente. No se ha demostrado capacidad para predecir el siguiente resultado ni se ha evaluado una ruleta real».

## 16 Cambiar X sin rehacer el proyecto

Cambien esta línea al principio del analizador:

```r
ultimas_x <- 50L
```

Después ejecuten **todo** `01_analizar_ruleta.R`. `recientes` y `resumen_ultimas_x.csv` se actualizarán a las últimas 50 tiradas. Los resúmenes de toda la muestra seguirán usando los 1000 registros. La comparación fija de 20, 100, 500 y todas las tiradas también se mantiene, porque responde a otra comparación.

Pueden introducir cualquier entero entre 1 y 1000 en el dataset entregado. Una ventana muy pequeña puede contener muchos números con frecuencia cero: el código los conserva para no confundir «no observado» con «no existe».

Para otro dataset, conserven el esquema `tirada;numero`, el modelo 0 a 36 y un identificador cronológico válido. No sustituyan un archivo propio por la simulación sin distinguir claramente su procedencia. Si utilizan otra modalidad de ruleta, estas categorías y probabilidades tendrían que revisarse.

## 17 Problemas habituales

| Situación | Qué deben revisar |
| --- | --- |
| No encuentra el CSV | Abran `ruleta.Rproj`, conserven la carpeta `datos` y comprueben la ruta con `getwd()`. |
| Todo aparece en una columna | Usen `read.csv2`, que espera punto y coma. |
| El generador indica que el archivo ya existe | Es una protección; el CSV ya está preparado. Ejecuten directamente el analizador. |
| Un bloque dice que no encuentra un objeto | Ejecuten primero los bloques anteriores o todo el script mediante Source. |
| Aparece `null device 1` | Es la confirmación de cierre del gráfico, no un fallo. |
| No hay gráfico en Plots | Consulten los PNG de la carpeta `resultados`. Se han guardado directamente en disco. |
| Las cifras no coinciden con esta guía | Comprueben que usan el CSV entregado, no una muestra regenerada con otra semilla o configuración. |
| Hay valores ausentes o fuera de rango | El script se detiene para que revisen el origen. No conviertan una ausencia en cero. |

## 18 Referencias técnicas

La implementación utiliza funciones documentadas de R. No requiere instalar extensiones:

- [Muestreo con sample](https://stat.ethz.ch/R-manual/R-devel/library/base/html/sample.html): argumentos `size`, `replace` y pesos de selección.
- [Generadores y set.seed](https://stat.ethz.ch/R-manual/R-devel/library/base/html/Random.html): semilla y opciones para reproducir una secuencia.
- [Tablas de frecuencias con table](https://stat.ethz.ch/R-manual/R-devel/library/base/html/table.html): conteos por categorías.
- [Suma acumulada con cumsum](https://stat.ethz.ch/R-manual/R-devel/library/base/html/cumsum.html): acumulación de los indicadores de rojo.

Procedencia del dataset: simulación del archivo `00_generar_datos.R`, semilla 2026, generador Mersenne-Twister, método de muestreo Rejection, 1000 elecciones con reposición del conjunto 0 a 36. No es evidencia observada de una ruleta física. La ejecución de preparación se ha comprobado con R 4.6.1.
