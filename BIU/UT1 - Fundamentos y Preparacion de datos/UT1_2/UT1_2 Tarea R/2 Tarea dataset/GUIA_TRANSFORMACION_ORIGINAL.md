# Guía sencilla de `transformacion.R` · Versión original

Archivo de referencia: `2 Tarea dataset/R/transformacion.R`, el que utilizará el alumnado.

El archivo contiene errores: se explica qué pretende hacer cada bloque y qué gráficos deberían aparecer al hacerlo funcionar.

## Qué contiene el dataset

`Data.csv` tiene **20.000 filas, 50 variables de entrada y una columna `class`**. Hay **4.749 valores ausentes**, representados como `NA`. El comentario que indica 2.000 filas es incorrecto.

Las columnas coinciden con datos para estudiar contactos entre aminoácidos. En esa representación, **una fila describe un par de aminoácidos de una proteína**. Es una interpretación respaldada por la [documentación científica](https://academic.oup.com/bioinformatics/article/28/19/2441/289358); falta confirmar el origen exacto de esta copia.

| Columnas | Lectura orientativa |
|---|---|
| `AA_freq_*` | Proporciones de determinados aminoácidos. |
| `PSSM_*` | Puntuaciones de aminoácidos en posiciones de la secuencia. Pueden ser negativas. |
| `PredCN_*` | Vecinos espaciales previstos, codificados en categorías. |
| `PredRCH_*` | Profundidad prevista dentro de la proteína. |
| `PredSA_*` | Exposición prevista al disolvente. |
| `PredSS_*` | Estructura prevista: `H`, hélice; `E`, hebra; `C`, bucle. |
| `length` | Longitud de la secuencia. |
| `separation` | Separación dentro de la secuencia, no distancia espacial. |
| `propensity` | Puntuación de tendencia al contacto; no es una probabilidad. |
| `class` | Etiqueta que se quiere clasificar: `positive` o `negative`. |

`r1` y `r2` identifican los dos aminoácidos; `central` se refiere a la región intermedia y `global`, al conjunto de la secuencia.

**Ejemplo, primera fila:** `length = 211`, `separation = 113`, `AA_freq_central_G = 0.071` y `class = negative`. La frecuencia equivale al 7,1 %. Falta el diccionario que confirme el significado exacto de las etiquetas de clase.

Hay **13.976 etiquetas `negative` y 6.024 `positive`**. En algunas columnas aparecen letras, como `X`: no deben convertirse automáticamente en números ni en ausencias.

## 1. Cargar las librerías y los datos

`library()` carga los paquetes; `setwd()` fija la carpeta de trabajo; `source("lecturaDatos.R")` ejecuta el archivo que lee el CSV.

**Revisen las rutas:** algunas corresponden a otro ordenador o a `r_examples`. Los CSV de esta tarea están un nivel por encima de `R/`.

## 2. Explorar los datos

- `nrow()` y `ncol()`: número de filas y columnas.
- `names()`, `head()` y `View()`: nombres, primeras filas y vista de la tabla.
- `summary()` y `describe()`: resumen de los valores.
- `str()`: tipos de las columnas.

`continuas`, `discretas` y `nominales` seleccionan columnas por posición. Omiten algunas; los tres `describe()` repiten `discretas`.

### Gráficos 1–4 · Cajas de variables

El código llama cuatro veces a `boxplot()`:

| Gráfico | Qué muestra |
|---|---|
| 1. Continuas | Las columnas seleccionadas, incluida `propensity`. |
| 2. Continuas | Las mismas, quitando `propensity` para ver mejor el resto. |
| 3. Discretas | Las columnas seleccionadas, incluidas `length` y `separation`. |
| 4. Discretas | Las mismas, quitando esas dos columnas de escala mayor. |

**Lectura:** horizontal = variables; vertical = valores. La línea de la caja es la mediana; la caja contiene la mitad central de los valores. Los puntos separados son posibles extremos, no errores confirmados.

Las discretas incluyen texto (`X`): sus boxplots pueden fallar hasta revisar la selección.

## 3. Filtrar filas con demasiadas ausencias

`source("filtrado.R")` calcula el porcentaje de ausencias de cada fila y elimina las que superan el **5 % de las 51 columnas**.

**Resultado comprobado del filtro:** se eliminan 30 filas. Quedan **19.970 filas, 51 columnas y 4.658 ausencias** en `Data-filtered.csv`.

### Gráfico 5 · Patrón de ausencias de MICE

`md.pattern(datos_filtrados)` muestra qué columnas faltan juntas.

- **Azul:** dato observado. **Rojo:** dato ausente.
- Cada fila del gráfico representa una combinación de presencia y ausencia.
- Los márgenes indican cuántas filas siguen cada patrón y cuántos valores faltan.

**Sirve para:** localizar columnas y combinaciones con ausencias.

### Gráfico 6 · Ausencias con VIM

`aggr()` muestra dos partes:

- **Izquierda:** proporción de ausencias de cada variable.
- **Derecha:** combinaciones de columnas observadas y ausentes, con sus frecuencias.

Azul significa observado y rojo, ausente. `X11()` solo abre una ventana gráfica; puede fallar si ese sistema gráfico no está disponible.

## 4. Estimar los valores ausentes con MICE

`mice()` estima valores ausentes utilizando otras columnas. `complete()` extrae una tabla con las imputaciones.

**`mice(datos)` utiliza los datos iniciales, aunque el bloque anuncie trabajar con los filtrados.** Comprueben el objeto procesado y si quedan ausencias.

`ccn()` e `icn()` pueden no estar disponibles. Para contar filas completas e incompletas pueden utilizar:

```r
sum(complete.cases(datos_filtrados))
sum(!complete.cases(datos_filtrados))
```

### Gráfico 7 · Clase frente a frecuencias

`xyplot()` pretende comparar `class` con tres frecuencias de aminoácidos.

- **Horizontal:** valor de la frecuencia.
- **Vertical:** categoría de `class`.
- Permite observar cómo se distribuyen esas frecuencias entre las dos clases.

Las referencias `datos$...` pueden causar problemas. El color automático depende de las ausencias de `class`, que no tiene ninguna: no identifica qué frecuencias se imputaron.

### Gráfico 8 · Densidades

`densityplot()` compara las distribuciones observadas e imputadas.

- **Horizontal:** valores de cada variable numérica.
- **Vertical:** concentración de valores, no cantidad de filas.
- **Azul:** observado. **Rojo:** imputado.

**Sirve para:** revisar diferencias de forma o valores estimados alejados de los observados. Curvas parecidas no garantizan estimaciones correctas.

### Gráfico 9 · Cajas de las imputaciones

`bwplot()` compara el centro y la dispersión de los valores.

- Cada panel corresponde a una variable numérica.
- **Horizontal:** grupo observado y distintas imputaciones.
- **Vertical:** valores de la variable.
- **Azul:** observado. **Rojo:** imputado.

**Sirve para:** detectar si una imputación genera valores mucho más altos, bajos o dispersos.

Si ejecutan mediante `source()`, envuelvan `xyplot()`, `densityplot()` y `bwplot()` en `print(...)` para mostrar los gráficos de lattice.

## 5. Probar otra imputación con robCompositions

`impKNNa()` intenta completar valores utilizando observaciones parecidas.

El objeto `datosanoma_filtrados_imputados_mice` no existe. Además, comparar métodos requiere partir de las mismas ausencias, no de datos ya imputados.

### Gráfico 10 · Diagrama ternario

`plot(imputados_rob, which = 3)` solicita un gráfico triangular de proporciones entre tres componentes.

**Cómo leerlo:** cerca de un vértice hay mayor proporción de ese componente; las marcas rojas identifican componentes originalmente ausentes.

Requiere datos composicionales apropiados. La selección mezcla frecuencias y una puntuación con negativos: ser numéricas no basta para que este método sea adecuado.

## 6. Detectar observaciones atípicas

`source("anomalias.R")` imprime extremos univariantes. Después, `uni.plot()` analiza conjuntamente las diez primeras columnas de la tabla imputada.

### Gráfico 11 · Candidatos atípicos

- Cada panel muestra una variable.
- **Vertical:** valores que `uni.plot()` centra y escala internamente de forma robusta. El `0` es la referencia central; alejarse indica mayor separación de esa referencia. No son las unidades originales.
- La posición horizontal solo separa puntos para verlos.
- **Rojo:** observaciones señaladas como atípicas al considerar varias variables juntas.

**Sirve para:** localizar observaciones que revisar. Un punto rojo no demuestra un error.

La línea que crea `datosFinales` **sí elimina las filas marcadas**. Conviene justificar esa decisión antes de ejecutarla.

## 7. Centrar y escalar: bloque pendiente

La intención es transformar los números mediante:

```text
(valor − media) / desviación típica
```

Pero `source("transformacion.R")` vuelve a ejecutar el mismo archivo: genera recursión. Tampoco se ha creado `datosFinales_escalados`. Por tanto, este bloque no realiza el escalado anunciado.

## 8. Discretizar y seleccionar variables

- `discretizacion.R` usa **iris**: 150 flores, cuatro medidas y su especie. CAIM, CACC y AMEVA calculan cortes para convertir medidas en intervalos. Imprime los cortes; no genera gráficos.
- `fSelector-cfs.R` selecciona variables de **iris**.
- `fSelector-chiSquared.R` y `fSelector-consistency.R` usan **HouseVotes84**: 435 representantes, 16 votaciones y su partido. Imprimen puntuaciones o selecciones; no generan gráficos.

Estos bloques cambian de dataset; sus selecciones no corresponden a `Data.csv`.

Documentación de los gráficos: [MICE](https://amices.org/mice/reference/densityplot.mids.html), [robCompositions](https://search.r-project.org/CRAN/refmans/robCompositions/html/plot.imp.html) y [mvoutlier](https://search.r-project.org/CRAN/refmans/mvoutlier/html/uni.plot.html).
