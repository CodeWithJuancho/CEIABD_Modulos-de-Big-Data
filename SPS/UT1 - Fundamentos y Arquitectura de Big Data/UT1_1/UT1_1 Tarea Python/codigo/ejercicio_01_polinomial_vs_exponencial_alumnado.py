"""Ejercicio 1. Polinomial frente a exponencial.
Completa ______ y sustituye cada ... por tu código.
Puedes consultar apuntes o Internet. Ejecuta los bloques cuando estén completos.
"""

# %% 1. Bibliotecas y datos de partida.
# Biblioteca para trabajar con vectores.
import numpy as np
# Interfaz gráfica de Matplotlib.
import matplotlib.pyplot as plt


m = 20
n = range(m)  # Tamaños desde 0 hasta m-1. Pista: a range.

y = np.zeros(len(n))  # Vector de ceros del mismo tamaño. Pista: zeros y len.
print(y)
# %% 2. Calcular el polinomio.
# Escribe un bucle que guarde el cuadrado de cada tamaño en y y lo imprima.
# La formula del polinomio es y = n²
for i in range(len(n)):
    y[i] = n[i] ** 2
    print(y[i])

# %% 3. Gráfico del polinomio con escala lineal.
# Crea una figura, dibuja n frente a y, añade título y muestra el gráfico.
# Pista: figure, plot, title, show.
plt.figure()
plt.plot(n, y)
plt.title("Gráfico del polinomio y = n²")
plt.xlabel("n")
plt.ylabel("y")
plt.show()

# %% 4. Gráfico del polinomio con escala vertical logarítmica.
# Dibuja los mismos datos en otra figura y cambia solo el eje vertical.
# Pista: yscale. El cero no se puede representar en esa escala.
plt.figure()
plt.plot(n, y)
plt.yscale('log')
plt.title("Gráfico del polinomio y = n² (escala logaritmica)")
plt.xlabel("n")
plt.ylabel("y")
plt.show()

# %% 5. Calcular la exponencial.
# Reinicia y y escribe el bucle para calcular e imprimir 2 elevado a cada tamaño.
y = np.zeros(len(n))
for i in range(len(n)):
    y[i] = 2 ** n[i]
    print(y[i])


# %% 6. Gráfico de la exponencial.
# Crea otra figura y representa n frente a y con el eje vertical logarítmico.
plt.figure()
plt.plot(n, y)
plt.yscale('log')
plt.title("Gráfico de la exponencial y = 2^n (escala logarítmica)")
plt.xlabel("n")
plt.ylabel("y")
plt.show()

# Responde con comentarios:
# ¿Qué función crece más deprisa? ¿Qué observas en las gráficas logarítmicas?
# La funcion exponencial crece más rápido que la función polinómica.
# En las gráficas logaritmicas, la funcion polinomica se ve una linea recta, 
# mientras que la funcion exponencial se ve una curva que se eleva rápidamente.
# Lo que quiere decir que la funcion exponencial crece más rapido que la polinomica.
