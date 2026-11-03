"""Ejercicio 1. Polinomial frente a exponencial.
Completa ______ y sustituye cada ... por tu código.
Puedes consultar apuntes o Internet. Ejecuta los bloques cuando estén completos.
"""

# %% 1. Bibliotecas y datos de partida.
# Biblioteca para trabajar con vectores.
# Interfaz gráfica de Matplotlib.

import numpy as np
import matplotlib.pyplot as plt


m = 20
n = np.arange(m)  # Tamaños desde 0 hasta m-1. Pista: arange.
y = np.zeros(len(n))  # Vector de ceros del mismo tamaño. Pista: zeros y len.

# %% 2. Calcular el polinomio.
# Escribe un bucle que guarde el cuadrado de cada tamaño en y y lo imprima.
for i in range(len(n)):
    y[i] = n[i] ** 2
    print (n[i], y[i])

# %% 3. Gráfico del polinomio con escala lineal.
# Crea una figura, dibuja n frente a y, añade título y muestra el gráfico.
# Pista: figure, plot, title, show.
plt.figure()
plt.plot(n, y)
plt.title("n^2 (escala lineal)")
plt.show()

# %% 4. Gráfico del polinomio con escala vertical logarítmica.
# Dibuja los mismos datos en otra figura y cambia solo el eje vertical.
# Pista: yscale. El cero no se puede representar en esa escala.
plt.figure()
plt.plot(n, y)
plt.yscale("log")
plt.title("n^2 (escala log)")
plt.show()

# %% 5. Calcular la exponencial.
# Reinicia y y escribe el bucle para calcular e imprimir 2 elevado a cada tamaño.
y = np.zeros(len(n))
for i in range(len(n)):
    y[i] = 2 ** n[i]
    print(n[i], y[i])

# %% 6. Gráfico de la exponencial.
# Crea otra figura y representa n frente a y con el eje vertical logarítmico.
plt.figure()
plt.plot(n, y)
plt.yscale("log")
plt.title("2^n (escala log)")
plt.show()

# Responde con comentarios:
# ¿Qué función crece más deprisa? ¿Qué observas en las gráficas logarítmicas?
# La exponencial 2^n es la que crece más deprisa. En escala log, n^2 se curva y se aplana, y 2^n sale como una recta.