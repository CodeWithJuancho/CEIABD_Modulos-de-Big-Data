# R: chuleta básica para los ejercicios

## 1. Objetos y sintaxis

| Código | Cómo leerlo |
|---|---|
| `# texto` | Comentario: explica el código y no se ejecuta. |
| `numero <- 17` | Guardar un valor en un objeto. |
| `"Rojo"` | Texto: se escribe entre comillas. |
| `0.5` | Número decimal: en R se utiliza punto. |
| `TRUE`, `FALSE` | Valores lógicos: verdadero y falso. |
| `100L` | Número escrito explícitamente como entero. |
| `c(0, 1, 2, 17, 36)` | Crear un vector: una colección de valores. |
| `0:36` | Generar los enteros del 0 al 36. |
| `round(48.6486, digits = 2)` | Llamar a una función y dar valor a un argumento. Devuelve `48.65`. |
| `{ ... }` | Agrupar instrucciones de una condición, función o bucle. |

Las mayúsculas importan: `datos` y `Datos` son nombres distintos. Los textos `"Rojo"` y `"rojo"` también son diferentes.

## 2. Una tabla para probar los ejemplos

```r
numero <- 17
datos <- data.frame(
  tirada = 1:5,
  numero = c(0, 1, 2, 17, 36)
)
```

| Código | Qué obtiene |
|---|---|
| `datos$numero` | La columna `numero`. |
| `datos[1, ]` | La primera fila, con todas sus columnas. |
| `datos[, "numero"]` | Los valores de esa columna. |
| `datos[1:3, ]` | Las tres primeras filas. |
| `datos[datos$numero != 0, ]` | Las filas cuyo número es distinto de cero. |
| `datos$doble <- datos$numero * 2` | Añadir una columna calculada. |

**Dentro de los corchetes: `[filas, columnas]`.** Una parte vacía conserva todas las filas o columnas. En R, las posiciones comienzan en **1**.

## 3. Operaciones y condiciones

| Operador | Significado | Ejemplo |
|---|---|---|
| `+`, `-`, `*`, `/`, `^` | Sumar, restar, multiplicar, dividir y elevar. | `43 / 1000 * 100` devuelve `4.3`. |
| `==`, `!=` | Igual o distinto. | `numero == 17` devuelve `TRUE`. |
| `<`, `>`, `<=`, `>=` | Comparar cantidades. | `numero <= 36` devuelve `TRUE`. |
| `!` | Negar una condición. | `!(numero == 0)` devuelve `TRUE`. |
| `&`, `\|` | Y / O, elemento a elemento. | Combinan condiciones para seleccionar filas. |
| `&&`, `\|\|` | Y / O entre condiciones individuales. | `numero >= 0 && numero <= 36`. |
| `%in%` | Pertenecer a un conjunto. | `numero %in% 0:36` devuelve `TRUE`. |
| `%%` | Resto de una división. | `17 %% 2` devuelve `1`. |

`&&` y `||` dejan de evaluar cuando la respuesta ya está decidida. Por ejemplo, si la primera condición de un `&&` es falsa, no evalúan la segunda.

```r
# Conservar las filas cuyos números están entre 1 y 12.
datos[datos$numero >= 1 & datos$numero <= 12, ]
```

**Asignar y comparar son cosas diferentes:** `numero <- 17` guarda el valor; `numero == 17` comprueba si coincide.

## 4. Condicionales: `if`, `else if` y `else`

`if` ejecuta un bloque si se cumple una condición. `else if` comprueba otra alternativa y `else` recoge el resto de casos.

```r
if (numero == 0) {
  paridad <- "Cero"
} else if (numero %% 2 == 0) {
  paridad <- "Par"
} else {
  paridad <- "Impar"
}

print(paridad)  # Con numero = 17, muestra "Impar".
```

- En R se escribe **`else if`**, separado, y pueden encadenar varias alternativas.
- Mantengan `} else` en la misma línea.
- `if` necesita **una única condición**, con resultado `TRUE` o `FALSE`, sin `NA`.

### `ifelse()`: una decisión para cada elemento

Para clasificar todos los valores de una columna:

```r
datos$paridad <- ifelse(
  datos$numero == 0, "Cero",
  ifelse(datos$numero %% 2 == 0, "Par", "Impar")
)
```

Se lee: `ifelse(condición, valor_si_se_cumple, valor_si_no)`. Aquí se obtiene un resultado por cada fila.

## 5. Funciones habituales

| Código | Para qué sirve |
|---|---|
| `print(datos)` | Mostrar la tabla en consola. |
| `cat("Total:", nrow(datos), "\n")` | Mostrar un mensaje; `\n` introduce un salto de línea. |
| `head(datos)`, `tail(datos, 3)` | Ver las primeras filas o las tres últimas. |
| `nrow(datos)`, `ncol(datos)` | Contar filas o columnas. |
| `names(datos)`, `str(datos)` | Consultar nombres y tipos de las columnas. |
| `length(datos$numero)` | Contar los elementos del vector. |
| `sum(datos$numero == 0)` | Contar ceros: `TRUE` cuenta como 1 y `FALSE` como 0. |
| `table(datos$numero)` | Contar apariciones de cada valor observado. |
| `table(factor(datos$numero, levels = 0:36))` | Contar conservando también los números con cero apariciones. |
| `rep(1 / 37, 37)` | Repetir una probabilidad 37 veces. |
| `cumsum(c(1, 0, 1))` | Sumar de forma acumulada: devuelve `1, 1, 2`. |

Para ordenar la tabla por el identificador de tirada:

```r
datos <- datos[order(datos$tirada), ]
```

## 6. Funciones propias y bucles

Una función reúne un cálculo para reutilizarlo. `return()` indica qué resultado devuelve.

```r
porcentaje <- function(casos, total) {
  return(100 * casos / total)
}

porcentaje(43, 1000)  # Devuelve 4.3.
```

Sin `return()`, R devuelve el resultado de la última expresión de la función.

Un bucle `for` repite un bloque para cada valor:

```r
for (tamano in c(20, 100, 500)) {
  print(tamano)
}
```

## 7. Valores ausentes: `NA`

`NA` significa que falta un dato. **No equivale a cero.** Comprueben las ausencias con `is.na()`, no con `x == NA`.

```r
valores <- c(10, NA, 20)
is.na(valores)                # FALSE, TRUE, FALSE.
sum(is.na(valores))           # Hay 1 valor ausente.
mean(valores, na.rm = TRUE)   # Media de los conocidos: 15.
```

`na.rm = TRUE` omite las ausencias en ese cálculo; no modifica el vector original.

**Al ejecutar:** respeten comillas, paréntesis y llaves, y creen los objetos antes de utilizarlos.
