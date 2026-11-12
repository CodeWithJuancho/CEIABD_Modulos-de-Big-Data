"""Ejercicio 1.b. Factorial.
Completa ______ y sustituye cada ... por tu código.
Puedes consultar apuntes o Internet. Ejecuta los bloques cuando estén completos.
"""

# %% 1. Bibliotecas y datos de partida.
# Biblioteca estándar de matemáticas.
# Biblioteca de vectores.
# Interfaz gráfica.

import math
import numpy as np
import matplotlib.pyplot as plt

m = 20
n = np.arange(m)  # Tamaños desde 0 hasta m-1. Pista: arange.
y = np.zeros(len(n))  # Vector de resultados inicialmente a cero. Pista: zeros.

# %% 2. Calcular factoriales.
# Escribe un bucle que calcule el factorial de cada tamaño, lo guarde y lo imprima.
# Pista: math dispone de una función para calcular factoriales.
for i in range(m):
    y[i] = math.factorial(n[i])
    print(n[i], y[i])

# %% 3. Representar los resultados.
# Dibuja n frente a y con el eje vertical logarítmico y un título.
# Pista: plot, yscale y show; crea una figura nueva para cada gráfico.
plt.figure()
plt.plot(n, y)
plt.yscale("log")
plt.title("Factorial n!, escala logarítmica")
plt.show()

# Responde con comentarios:
# Compara con 2 elevado a n. ¿Cómo clasificarías el crecimiento del factorial?
# El factorial crece mucho más deprisa que 2^n. Con n = 19, 2^n vale 524288
# mientras que n! vale aproximadamente 1.2 * 10^17. Además, la diferencia se
# agranda a medida que n aumenta.
# En la gráfica logarítmica, 2^n es una línea recta, pero n! se curva hacia
# arriba. Por eso el factorial no es polinomial, crece incluso más que una
# exponencial.