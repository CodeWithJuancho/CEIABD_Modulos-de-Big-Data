"""Ejercicio 2. Roadrunner.
Encuentra el mayor tamaño entero resoluble en un año de 365 días.
Coste: 10 elevado a la raíz cuadrada de [n * logaritmo decimal de n].
Completa ______ y sustituye cada ... por tu código. Puedes consultar recursos.
"""

# %% 1. Biblioteca y datos de partida.
# Biblioteca estándar de matemáticas.
import math

velocidad_cpu = 1.105 * 10**15  # Operaciones por segundo.
dias = 365
segundos = dias * 24 * 60 * 60     # Convierte los días a segundos.
presupuesto = velocidad_cpu * segundos  # Calcula las operaciones disponibles en ese tiempo.

# %% 2. Programar el coste.
def coste(n):
    # Traduce la fórmula del enunciado y devuelve su valor.
    # Pista: raíz, logaritmo decimal y potencias de Python.
    return 10 ** (math.sqrt(n * math.log10(n)))

# %% 3. Buscar el límite.
n = 1
# Escribe un bucle que avance de uno en uno mientras el coste sea admisible.
# Recalcula el coste en cada paso; considera admisible la igualdad.
while coste(n) <= presupuesto:
    n += 1

# %% 4. Mostrar y comprobar el resultado.
# Obtén el último tamaño admisible y muestra su valor.
# Comprueba también que el entero siguiente supera el presupuesto.
n -= 1
print(f"El mayor tamaño entero resoluble en un año es: {n}")
print(f"Coste para n={n}: {coste(n)}")
print(f"Coste para n={n+1}: {coste(n+1)}")

# Responde con comentarios:
# ¿Qué valor representa n cuando termina tu búsqueda?
# n representa el mayor tamaño entero resoluble en un año, segun la funcion del coste dado.
# En la consola me muestra que el mayor tamaño enreto resoluble en un año es: 217
