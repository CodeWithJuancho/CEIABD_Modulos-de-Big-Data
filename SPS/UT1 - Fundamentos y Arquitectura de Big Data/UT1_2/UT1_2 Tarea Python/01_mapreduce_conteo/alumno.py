# %% Presentación del bloque
"""Conteo de registros por categoría H/M con MapReduce simulado.

Python 3.10 o posterior. Solo biblioteca estándar.
Simulación serial y local: no ejecuta Hadoop ni reproduce HDFS, collect,
spill, merge, planificación o tolerancia a fallos. No permite sacar
conclusiones de rendimiento distribuido.
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

# Paso 1 (a mano): la clave intermedia es la CATEGORÍA (último campo),
# porque es aquello por lo que se quiere contar. Esperado: H=5, M=4, total 9.
#   1800: H, H, M | 1801: M, H, M | 1802: H, M, H


# %% Map: parseo, validación y emisión
def map_registro(linea: str) -> tuple[str, int]:
    """Recibe una línea sin terminador y emite (categoría, 1)."""
    if "\n" in linea or "\r" in linea:
        raise ValueError("el registro contiene un salto de línea interno")
    if not linea.strip():
        raise ValueError("registro vacío")
    if linea.count(",") != 1:
        raise ValueError(
            f"el registro debe tener exactamente una coma: {linea!r}"
        )
    nombre, _, categoria = linea.rpartition(",")
    nombre = nombre.strip()
    categoria = categoria.strip()
    if not nombre:
        raise ValueError(f"nombre vacío: {linea!r}")
    if categoria not in CATEGORIAS:
        raise ValueError(
            f"categoría inválida {categoria!r} (se esperaba H o M): {linea!r}"
        )
    return (categoria, 1)


# %% Shuffle: agrupación sin perder repeticiones
def shuffle(pares: list[tuple[str, int]]) -> dict[str, list[int]]:
    """Agrupa las emisiones Map: una lista de valores por clave."""
    grupos: defaultdict[str, list[int]] = defaultdict(list)
    for clave, valor in pares:
        grupos[clave].append(valor)  # cada 1 se conserva
    return dict(grupos)


# %% Reduce: cálculo por categoría
def reduce_categoria(clave: str, valores: list[int]) -> tuple[str, int]:
    """Devuelve (categoría, total) para un único grupo."""
    total = 0
    for valor in valores:
        total += valor
    # Contraste con sum
    assert total == sum(valores), "el bucle y sum deben coincidir"
    return (clave, total)


# %% Coordinación de las fases
def ejecutar_mapreduce(ficheros: dict[str, str]) -> dict[str, int]:
    """Devuelve el conteo de las categorías presentes en los registros."""
    pares = _fase_map(ficheros)
    grupos = shuffle(pares)
    resultado: dict[str, int] = {}
    for clave, valores in grupos.items():
        categoria, total = reduce_categoria(clave, valores)
        resultado[categoria] = total
    return resultado


def _fase_map(ficheros: dict[str, str]) -> list[tuple[str, int]]:
    """Aplica Map a todas las líneas, indicando fichero y línea si falla."""
    pares: list[tuple[str, int]] = []
    for nombre_fichero, contenido in ficheros.items():
        # splitlines no genera registro extra por el LF final
        for n_linea, linea in enumerate(contenido.splitlines(), start=1):
            try:
                pares.append(map_registro(linea))
            except ValueError as error:
                raise ValueError(
                    f"{nombre_fichero}, línea {n_linea}: {error}"
                ) from error
    return pares


# %% Contraste secuencial
def conteo_secuencial(ficheros: dict[str, str]) -> dict[str, int]:
    """Cuenta directamente H/M, sin emisiones ni grupos."""
    contadores: dict[str, int] = {}
    for nombre_fichero, contenido in ficheros.items():
        for n_linea, linea in enumerate(contenido.splitlines(), start=1):
            try:
                categoria, _ = map_registro(linea)  # reutiliza la validación
            except ValueError as error:
                raise ValueError(
                    f"{nombre_fichero}, línea {n_linea}: {error}"
                ) from error
            contadores[categoria] = contadores.get(categoria, 0) + 1
    return contadores


# %% Mostrar las fases y comprobar el resultado
def mostrar_demostracion() -> None:
    """Traza las fases y comprueba que no se pierde ningún registro."""
    n_registros = sum(len(c.splitlines()) for c in FICHEROS.values())

    print("== MAP: una emisión por registro ==")
    pares = _fase_map(FICHEROS)
    for par in pares:
        print(" ", par)

    print("\n== SHUFFLE: grupos por clave ==")
    grupos = shuffle(pares)
    for clave in sorted(grupos):
        print(f"  {clave}: {grupos[clave]}")

    print("\n== REDUCE: salida por categoría ==")
    for clave in sorted(grupos):
        print(" ", reduce_categoria(clave, grupos[clave]))

    mapreduce = ejecutar_mapreduce(FICHEROS)
    secuencial = conteo_secuencial(FICHEROS)
    print("\nMapReduce :", mapreduce)
    print("Secuencial:", secuencial)

    n_agrupados = sum(len(v) for v in grupos.values())
    h, m = mapreduce.get("H", 0), mapreduce.get("M", 0)

    assert mapreduce == secuencial, "los métodos no coinciden"
    assert n_registros == len(pares) == n_agrupados, "se perdieron datos"
    assert h + m == n_registros == 9, "H + M debe ser 9"
    assert (h, m) == (5, 4), "no coincide con el cálculo a mano"

    print(f"\nRegistros={n_registros}, emisiones={len(pares)}, "
          f"valores agrupados={n_agrupados}")
    print(f"H={h}, M={m}, H+M={h + m}  -> comprobaciones OK")


# %% Ejecutar tu demostración
if __name__ == "__main__":
    mostrar_demostracion()
