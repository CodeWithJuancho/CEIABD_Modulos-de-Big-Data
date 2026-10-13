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


    # 1. Validación de saltos de línea
    if "\n" in linea or "\r" in linea:
        raise ValueError("La línea contiene saltos de línea internos")
    
    # 2. Separar por comas
    nombre_raw, sep, categoria_raw = linea.rpartition(",")

    # 3. Comprobar que solo hay una coma
    if sep != ",":
        raise ValueError("La línea no contiene exactamente una coma")
    if "," in nombre_raw:
        raise ValueError("El nombre contiene más de una coma")
    
    # 4. Limpiar espacios y validar contenido
    nombre = nombre_raw.strip()
    categoria = categoria_raw.strip()

    # 5. Validar nombre y categoría
    if not nombre:
        raise ValueError("El nombre está vacío")
    if categoria not in CATEGORIAS:
        raise ValueError(f"Categoría inválida: {categoria}")

    # 6. Emitir par (categoría, 1)
    return (categoria, 1)

# %% Shuffle: agrupación sin perder repeticiones
def shuffle(pares: list[tuple[str, int]]) -> dict[str, list[int]]:
    """Recibe emisiones Map y devuelve una lista de valores por clave.

    TODO: escribe el recorrido de pares y la construcción de los grupos.
    Cada 1 debe conservarse, aunque otros valores sean iguales.
    Pista: defaultdict puede facilitar la creación de listas vacías.
    """
    grupos: dict[str, list[int]] = defaultdict(list)
    for clave, valor in pares:
        grupos[clave].append(valor)
    return dict(grupos)  


# %% Reduce: cálculo por categoría
def reduce_categoria(clave: str, valores: list[int]) -> tuple[str, int]:
    """Devuelve (categoría, total) para un único grupo.

    TODO: escribe la acumulación de los valores y devuelve el par de salida.
    Pista: resuélvelo primero con un bucle. Después puedes compararlo con sum.
    """
    total = 0
    for valor in valores:
        total += valor

    assert total == sum(valores), "La suma acumulada no coincide con sum()"

    return (clave, total)


# %% Coordinación de las fases
def ejecutar_mapreduce(ficheros: dict[str, str]) -> dict[str, int]:
    """Devuelve el conteo de las categorías presentes en los registros.

    TODO: recorre los ficheros y sus líneas, llama a Map y recoge sus pares.
    Después agrupa y aplica Reduce a cada clave. Construye el resultado.
    Los errores deben indicar fichero y número de línea, sin ignorarlos.
    Pista: splitlines, enumerate y los contratos de las funciones anteriores.
    """
    emisiones: list[tuple[str, int]] = []

    # 1. Fase Map: recorrer cada fichero y cada línea
    for nombre_fichero, contenido in ficheros.items():
        for numero_linea, linea in enumerate(contenido.splitlines(), start=1):
            try:
                par = map_registro(linea)
                emisiones.append(par)
            except ValueError as e:
                raise ValueError(f"Error en {nombre_fichero}, línea {numero_linea}: {e}") from e

    # 2. Fase Shuffle: agrupar por clave
    grupos = shuffle(emisiones)

    # 3. Fase Reduce: sumar cada grupo y construir el diccionario final
    resultados: dict[str, int] = {}
    for clave, valores in grupos.items():
        resultado = reduce_categoria(clave, valores)
        resultados[resultado[0]] = resultado[1]
    return resultados


# %% Contraste secuencial
def conteo_secuencial(ficheros: dict[str, str]) -> dict[str, int]:
    """Cuenta directamente los registros H/M sin crear listas de emisiones.

    TODO: recorre y valida los datos. Actualiza un contador por categoría.
    Este recorrido permitirá contrastar tu resultado MapReduce.
    """
    contadores: dict[str, int] = {}

    for nombre_fichero, contenido in ficheros.items():
        for numero_linea, linea in enumerate(contenido.splitlines(), start=1):
            try:
                categoria, _ = map_registro(linea)
            except ValueError as e:
                raise ValueError(f"Error en {nombre_fichero}, línea {numero_linea}: {e}") from e

            contadores[categoria] = contadores.get(categoria, 0) + 1
    return contadores


# %% Mostrar las fases y comprobar el resultado
def mostrar_demostracion() -> None:
    """Construye una traza de los datos preparados.

    TODO: muestra una emisión por registro, los grupos y cada salida Reduce.
    Ejecuta ambos métodos y comprueba su igualdad. Comprueba también que el
    número de registros, emisiones y valores agrupados coincide con H + M.
    Calcula los conteos de H y M. Su suma debe ser igual a los 9 registros.
    """
    print("=== Fase Map ===")
    emisiones: list[tuple[str, int]] = []
    total_registros = 0

    for nombre_fichero, contenido in FICHEROS.items():
        for numero_linea, linea in enumerate(contenido.splitlines(), start=1):
            total_registros += 1
            try:
                par = map_registro(linea)
                emisiones.append(par)
                print(f"{nombre_fichero}, línea {numero_linea}: {par}")
            except ValueError as e:
                print(f"Error en {nombre_fichero}, línea {numero_linea}: {e}")

    print("\n=== 2. FASE SHUFFLE (Agrupación por categoría) ===")
    grupos = shuffle(emisiones)
    for clave, valores in grupos.items():
        print(f"  Grupo '{clave}': {valores}")  


    print("\n=== 3. FASE REDUCE (Resultados por categoría) ===")
    resultado_traza: dict[str, int] = {}
    for clave, valores in grupos.items():
        par_reducido = reduce_categoria(clave, valores)
        resultado_traza[par_reducido[0]] = par_reducido[1]
        print(f"  Reduce '{clave}' -> {par_reducido}")


    print("\n=== 4. COMPARACIÓN Y COMPROBACIONES ===")
    resultado_mr = ejecutar_mapreduce(FICHEROS)
    resultado_sec = conteo_secuencial(FICHEROS)

    print(f"  Resultado MapReduce : {resultado_mr}")
    print(f"  Resultado Secuencial: {resultado_sec}")

    # Evidencias requeridas por el guion
    total_valores_agrupados = sum(len(v) for v in grupos.values())
    conteo_h = resultado_mr.get("H", 0)
    conteo_m = resultado_mr.get("M", 0)
    suma_hm = conteo_h + conteo_m

    assert len(emisiones) == 9, "Debe haber exactamente 9 emisiones Map."
    assert len(grupos) == 2, "Debe haber exactamente 2 grupos (H y M)."
    assert resultado_mr == resultado_traza == resultado_sec, (
        "Los resultados de MapReduce y el conteo secuencial no coinciden."
    )
    assert total_registros == len(emisiones) == total_valores_agrupados == suma_hm == 9, (
        "Se ha perdido algún registro durante el proceso."
    )

    print(
        f"  Comprobación OK: Registros ({total_registros}) == "
        f"Emisiones ({len(emisiones)}) == Valores agrupados ({total_valores_agrupados}) == "
        f"H + M ({conteo_h} + {conteo_m} = {suma_hm})."
    )



# %% Ejecutar tu demostración
if __name__ == "__main__":
    mostrar_demostracion()
