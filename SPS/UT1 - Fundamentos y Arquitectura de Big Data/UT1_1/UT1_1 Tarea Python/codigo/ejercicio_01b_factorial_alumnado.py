"""Ejercicio 1.b. Factorial.
Completa ______ y sustituye cada ... por tu código.
Puedes consultar apuntes o Internet. Ejecuta los bloques cuando estén completos.
"""

# %% 1. Bibliotecas y datos de partida.
import math  # Aseguramos la importación completa de math para el factorial
from math import sqrt
import tkinter
import numpy as np
import matplotlib.pyplot as plt

m = 20
n = np.arange(0, m)   # Tamaños desde 0 hasta m-1. Pista: arange.
y = np.zeros(len(n))  # Vector de resultados inicialmente a cero. Pista: zeros.

# %% 2. Calcular factoriales.
# Escribe un bucle que calcule el factorial de cada tamaño, lo guarde y lo imprima.
# Pista: math dispone de una función para calcular factoriales.
for i in range(len(n)):
    y[i] = math.factorial(n[i])  # Usamos math.factorial directamente
    print(f"Factorial de {n[i]}: {y[i]}")

# %% 3. Representar los resultados.
# Dibuja n frente a y con el eje vertical logarítmico y un título.
# Pista: plot, yscale y show; crea una figura nueva para cada gráfico.
plt.figure(figsize=(10, 6))
plt.plot(n, y, marker="o", color="blue", label="n!")
plt.yscale("log")  # Cambia el eje Y a escala logarítmica
plt.title("Gráfico del factorial (escala logarítmica)")
plt.xlabel("Tamaño (n)")
plt.ylabel("Valor (y)")
plt.grid(True, which="both", linestyle="--", alpha=0.5)
plt.legend()
plt.show()

# %% 4. Respuestas a las preguntas:
# Compara con 2 elevado a n. ¿Cómo clasificarías el crecimiento del factorial?
#
# El factorial ($n!$) es tan rápido y se dispara tanto que, si intentas calcularlo con números grandes en un ordenador, 
# el programa se quedará pensando eternamente porque el número se vuelve gigantesco en cuestión de segundos. 
# Es lo que llamamos un crecimiento superexponencial (de los más lentos e imposibles de calcular en informática cuando la $n$ es grande).