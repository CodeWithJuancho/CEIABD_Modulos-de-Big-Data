"""Ejercicio 1. Polinomial frente a exponencial.
Completa ______ y sustituye cada ... por tu código.
Puedes consultar apuntes o Internet. Ejecuta los bloques cuando estén completos.
"""

# %% 1. Bibliotecas y datos de partida.
# Biblioteca para trabajar con vectores.
# Interfaz gráfica de Matplotlib.

import numpy
import matplotlib.pyplot as plt

m = 20
n = numpy.arange(m)  # Tamaños desde 0 hasta m-1. Pista: arange.
y = numpy.zeros(len(n))  # Vector de ceros del mismo tamaño. Pista: zeros y len.

# %% 2. Calcular el polinomio.
# Escribe un bucle que guarde el cuadrado de cada tamaño en y y lo imprima.
for i in range(m):
    y[i] = n[i] ** 2
    print(n[i], y[i])

# %% 3. Gráfico del polinomio con escala lineal.
# Crea una figura, dibuja n frente a y, añade título y muestra el gráfico.
# Pista: figure, plot, title, show.
plt.figure()
plt.plot(n, y)
plt.title("Polinomio n^2, escala lineal")
plt.show()

# %% 4. Gráfico del polinomio con escala vertical logarítmica.
# Dibuja los mismos datos en otra figura y cambia solo el eje vertical.
# Pista: yscale. El cero no se puede representar en esa escala.
plt.figure()
plt.plot(n, y)
plt.yscale("log")
plt.title("Polinomio n^2, escala logarítmica")
plt.show()

# %% 5. Calcular la exponencial.
# Reinicia y y escribe el bucle para calcular e imprimir 2 elevado a cada tamaño.
y = numpy.zeros(len(n))
for i in range(m):
    y[i] = 2 ** n[i]
    print(n[i], y[i])

# %% 6. Gráfico de la exponencial.
# Crea otra figura y representa n frente a y con el eje vertical logarítmico.
plt.figure()
plt.plot(n, y)
plt.yscale("log")
plt.title("Exponencial 2^n, escala logarítmica")
plt.show()

# Responde con comentarios:
# ¿Qué función crece más deprisa? ¿Qué observas en las gráficas logarítmicas?
# La exponencial 2^n crece mucho más deprisa que el polinomio n^2. Con n = 19,
# n^2 vale 361 mientras que 2^n vale 524288. Además, la diferencia se agranda
# a medida que n aumenta.
# La gráfica de n^2 sube cada vez más despacio y se aplana. En cambio,
# la gráfica de 2^n es una línea recta.