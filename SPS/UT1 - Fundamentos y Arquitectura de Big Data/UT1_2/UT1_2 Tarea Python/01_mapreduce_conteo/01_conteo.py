# %% Presentación del bloque
"""Plantilla intermedia: conteo de registros por categoría H/M.

Python 3.10 o posterior. Solo biblioteca estándar.
Completa las funciones sustituyendo cada NotImplementedError.
Los tres primeros registros son los del ejemplo de la diapositiva 3.
Los otros seis son ficticios y se han añadido para esta práctica.
Cada fichero representa un split lógico didáctico. La ejecución es serial
y local. Esta plantilla no ejecuta Hadoop.
"""

# %% Imports y datos preparados
from collections import defaultdict


FICHEROS: dict[str, str] = {
    "1800.txt": (
        "Manuel García García, H\n"
        "Juan Belmonte Pérez, H\n"
        "María Selas Rodríguez, M\n"
    ),
    "1801.txt": (
        "Lucía Martín Pérez, M\n"
        "Diego Ramos Díaz, H\n"
        "Elena Suárez León, M\n"
    ),
    "1802.txt": (
        "Pablo Torres Gil, H\n"
        "Nora Medina Ruiz, M\n"
        "Iván Cabrera Soto, H\n"
    ),
}

CATEGORIAS = ("H", "M")


# %% Map: parseo, validación y emisión
def map_registro(linea: str) -> tuple[str, int]:
    """Recibe una línea sin terminador y emite (categoría, 1).

    TODO: separa nombre y categoría. Rechaza nombres vacíos, registros
    sin una única coma, saltos de línea internos y categorías inválidas.
    Lee H/M del campo final. No deduzcas la categoría a partir del nombre.
    Pista: investiga rpartition y strip.
    """
    raise NotImplementedError("Completa el parseo, la validación y Map")


# %% Shuffle: agrupación sin perder repeticiones
def shuffle(pares: list[tuple[str, int]]) -> dict[str, list[int]]:
    """Recibe emisiones Map y devuelve una lista de valores por clave.

    TODO: escribe el recorrido de pares y la construcción de los grupos.
    Cada 1 debe conservarse, aunque otros valores sean iguales.
    Pista: defaultdict puede facilitar la creación de listas vacías.
    """
    raise NotImplementedError("Completa la agrupación por clave")


# %% Reduce: cálculo por categoría
def reduce_categoria(clave: str, valores: list[int]) -> tuple[str, int]:
    """Devuelve (categoría, total) para un único grupo.

    TODO: escribe la acumulación de los valores y devuelve el par de salida.
    Pista: resuélvelo primero con un bucle. Después puedes compararlo con sum.
    """
    raise NotImplementedError("Completa Reduce")


# %% Coordinación de las fases
def ejecutar_mapreduce(ficheros: dict[str, str]) -> dict[str, int]:
    """Devuelve el conteo de las categorías presentes en los registros.

    TODO: recorre los ficheros y sus líneas, llama a Map y recoge sus pares.
    Después agrupa y aplica Reduce a cada clave. Construye el resultado.
    Los errores deben indicar fichero y número de línea, sin ignorarlos.
    Pista: splitlines, enumerate y los contratos de las funciones anteriores.
    """
    raise NotImplementedError("Completa los bucles que coordinan MapReduce")


# %% Contraste secuencial
def conteo_secuencial(ficheros: dict[str, str]) -> dict[str, int]:
    """Cuenta directamente los registros H/M sin crear listas de emisiones.

    TODO: recorre y valida los datos. Actualiza un contador por categoría.
    Este recorrido permitirá contrastar tu resultado MapReduce.
    """
    raise NotImplementedError("Completa el conteo secuencial de referencia")


# %% Mostrar las fases y comprobar el resultado
def mostrar_demostracion() -> None:
    """Construye una traza de los datos preparados.

    TODO: muestra una emisión por registro, los grupos y cada salida Reduce.
    Ejecuta ambos métodos y comprueba su igualdad. Comprueba también que el
    número de registros, emisiones y valores agrupados coincide con H + M.
    Calcula los conteos de H y M. Su suma debe ser igual a los 9 registros.
    """
    raise NotImplementedError("Completa la demostración y las comprobaciones")


# %% Ejecutar tu demostración
if __name__ == "__main__":
    mostrar_demostracion()
