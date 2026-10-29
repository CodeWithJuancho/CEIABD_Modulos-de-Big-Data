## Sintaxis mínima del lenguaje de progrmación R para entender los scripts

| Elemento de R | Cómo leerlo |
| --- | --- |
| `# texto` | Comentario: explica el código y no se ejecuta. |
| `x <- 100` | Guardar 100 en el objeto llamado `x`. |
| `size = 1000` | Dar un valor a un argumento de una función. |
| `c(1, 3, 5)` | Crear un vector con varios elementos. |
| `0:36` | Crear la secuencia de enteros del 0 al 36. |
| `100L` | Escribir explícitamente un número entero. |
| `datos$numero` | Acceder a la columna `numero` de `datos`. |
| `datos[filas, columnas]` | Seleccionar filas y columnas de una tabla. Una parte vacía significa conservarlas todas. |
| `==` y `!=` | Comparar igualdad o desigualdad. No asignan valores. |
| `<`, `>`, `<=`, `>=` | Comparar cantidades. |
| `!condicion` | Negar una condición. |
| `condicion1 \| condicion2` | Comprobar, elemento a elemento, si se cumple al menos una condición. |
| `condicion1 \|\| condicion2` | Comprobar condiciones individuales y detener la evaluación cuando ya se conoce la respuesta. Se utiliza en los controles del script. |
| `%in%` | Comprobar si un valor pertenece a un conjunto. |
| `%%` | Calcular el resto de una división. |
| `{ ... }` | Agrupar las instrucciones de una función, un bucle o una condición. |

Las mayúsculas importan: `Rojo`, `rojo` y `ROJO` son textos diferentes. Los nombres usados en los scripts se mantienen consistentes.