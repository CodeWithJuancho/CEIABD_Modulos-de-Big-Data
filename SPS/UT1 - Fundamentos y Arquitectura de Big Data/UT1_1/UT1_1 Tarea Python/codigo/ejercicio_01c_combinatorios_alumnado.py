"""Ejercicio 1.c. Números combinatorios.
Fórmula: C(a,b) = a! / (b! * (a-b)!).
Completa ______ y sustituye cada ... por tu código. Puedes consultar recursos.
"""

# %% 1. Bibliotecas y datos de partida.
from math import sqrt
import math
import numpy as np
import matplotlib.pyplot as plt

m = 20
k = 4
n = np.arange(0,m, +1)  # Vector de valores de n.
y = np.zeros(len(n))  # Vector de resultados inicialmente a cero. Pista: zeros.

# %% 2. Programar las combinaciones.
def comb(a, b):
    # Implementa la fórmula del enunciado con factoriales y devuelve el resultado.
    return math.factorial(a) // (math.factorial(b) * math.factorial(a - b))

# %% 3. Calcular los valores.
# Escribe un bucle que calcule C(i+k,k), guarde cada resultado en y y lo imprima.
for i in range(len(n)):
    y[i] = comb(n[i] + k, k)
    print(f"Combinatorio C({n[i]}+{k},{k}): {y[i]}")

# %% 4. Representar los resultados.
# Dibuja n frente a y con el eje vertical logarítmico y un título.
# Pista: figure, plot, yscale y show.
plt.figure(figsize=(10, 6))
plt.plot(n, y, marker="o", color="blue", label="C(n+k,k)")
plt.yscale("log")
plt.title("Gráfico de los números combinatorios (Escala Logarítmica)")
plt.xlabel("Tamaño (n)")
plt.ylabel("Valor (y)")
plt.grid(True, which="both", alpha=0.3)
plt.legend()
plt.show()

# Responde con comentarios:
# Simplifica C(i+4,4). ¿Qué crecimiento tiene cuando k permanece fijo?

# 1. Simplificación algebraica:
#    C(i+4, 4) = (i+4)! / (4! * i!) 
#              = [(i+4) * (i+3) * (i+2) * (i+1) * i!] / (24 * i!)
#              = (i+4)(i+3)(i+2)(i+1) / 24
#
# 2. Clasificación del crecimiento:
#    Aunque el código usa factoriales por dentro (que parecen caóticos), el resultado final de este cálculo específico crece de forma polinomial 
#   (como una potencia normal y corriente, no como una exponencial salvaje). 
#   Por eso en la gráfica se comporta como un polinomio manso y no como una línea recta exponencial.