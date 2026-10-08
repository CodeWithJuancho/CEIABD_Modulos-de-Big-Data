import datetime as dt
import pandas as pd
from pathlib import Path



#Obtenemos la fecha y le damos el formato que queremos
def obtener_fecha():
    fecha = dt.date.today().strftime("%m_%d_%y")
    return fecha

#Leemos y recorremos el archivo de usuarios
def procesar_archivo():
    #Creamos una ruta relativa para que sea mucho más fácil acceder a los archivos y no tener que poner la ruta completa
    base_path = Path(__file__).resolve().parent.parent
    csv_path = base_path / "users" / "extracted" / "users.csv"
    txt_path = base_path / "scripts" / "logs" 
    df = pd.read_csv(csv_path, sep=',')
       
    # Separar filas con vacíos de las filas completas, con axis=1 le indicamos que busque horizontalmente.
    filas_rechazadas = df[df.isna().any(axis=1)]
    filas_aceptadas = df[~df.isna().any(axis=1)]

    #Creamos el archivo de las filas rechazadas, ya arriba creé la ruta relativa para que sea más fácil acceder a los archivos
    ruta_rechazados = f"{txt_path}/{obtener_fecha()}_rejected_rows.txt"

    #Abrimos el archivo en modo escritura ("w") y escribimos la primera línea
    with open(ruta_rechazados, "w", encoding="utf-8") as f:
        f.write(f"Han sido rechazadas {len(filas_rechazadas)} filas por tener valores vacíos.\n")

    # Con mode="a", Pandas añade la tabla justo debajo sin borrar la línea anterior, con index le indicamos si queremos que añada el número de índice asignado por panda.
        filas_rechazadas.to_csv(ruta_rechazados, mode="a", sep=",", index=False)

    #Repetimos el proceso con las filas correctas, aunque en este caso solo debemos mostrar 
    ruta_aceptados = f"{txt_path}/{obtener_fecha()}_imported_rows.txt"

    with open(ruta_aceptados, "w", encoding="utf-8") as f:
        f.write(f"Total de registros: {len(filas_aceptadas)}\n")

        




obtener_fecha()
procesar_archivo()