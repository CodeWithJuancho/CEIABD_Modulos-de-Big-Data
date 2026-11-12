"""Ejercicio 1. Polinomial frente a exponencial.
Completa ______ y sustituye cada ... por tu código.
Puedes consultar apuntes o Internet. Ejecuta los bloques cuando estén completos.
"""

# %% 1. Bibliotecas y datos de partida.
import numpy as np
import matplotlib.pyplot as plt

m = 20
n = np.arange(0, m)   # Tamaños desde 0 hasta m-1. Pista: arange.
y = np.zeros(len(n))  # Vector de ceros del mismo tamaño. Pista: zeros y len.


# %% 2. Calcular el polinomio.
# Escribe un bucle que guarde el cuadrado de cada tamaño en y y lo imprima.
for i in range(len(n)):
    y[i] = n[i] ** 2
    print(f"Polinomial n={n[i]}: {y[i]}")


# %% 3. Gráfico del polinomio con escala lineal.
# Crea una figura, dibuja n frente a y, añade título y muestra el gráfico.
plt.figure(figsize=(10, 6))
plt.plot(n, y, marker="o", color="blue", label="$n^2$")
plt.title("Gráfico del polinomio (Escala Lineal)")
plt.xlabel("Tamaño (n)")
plt.ylabel("Valor (y)")
plt.grid(True, alpha=0.3)
plt.legend()
plt.show()

# %% 4. Gráfico del polinomio con escala vertical logarítmica.
# Dibuja los mismos datos en otra figura y cambia solo el eje vertical.
# Pista: yscale. El cero no se puede representar en esa escala.
plt.figure(figsize=(10, 6))
plt.plot(n[1:], y[1:], marker="o", color="blue", label="$n^2$")
plt.yscale("log")
plt.title("Gráfico del polinomio (Escala Logarítmica)")
plt.xlabel("Tamaño (n)")
plt.ylabel("Valor (y)")
plt.grid(True, which="both", alpha=0.3)
plt.legend()
plt.show()

# %% 5. Calcular la exponencial.
# Reinicia y y escribe el bucle para calcular e imprimir 2 elevado a cada tamaño.
y = np.zeros(len(n))  # Reiniciamos el vector y a ceros
for i in range(len(n)):
    y[i] = 2 ** n[i]
    print(f"Exponencial n={n[i]}: {y[i]}")

# %% 6. Gráfico de la exponencial.
# Crea otra figura y representa n frente a y con el eje vertical logarítmico.
plt.figure(figsize=(10, 6))
plt.plot(n, y, marker="s", color="red", label="$2^n$")
plt.yscale("log")
plt.title("Gráfico de la exponencial (Escala Logarítmica)")
plt.xlabel("Tamaño (n)")
plt.ylabel("Valor (y)")
plt.grid(True, which="both", alpha=0.3)
plt.legend()
plt.show()

# Responde con comentarios:
# ¿Qué función crece más deprisa? ¿Qué observas en las gráficas logarítmicas?
#
# El ejercicio demuestra que las funciones exponenciales crecen de forma mucho más agresiva y rápida que las polinómicas, 
# y que los gráficos con escala logarítmica sirven precisamente para ver esto con los ojos 
# (haciendo que la exponencial sea una línea recta perfecta).
