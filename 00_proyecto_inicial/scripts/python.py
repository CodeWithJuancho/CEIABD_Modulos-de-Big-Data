import datetime as dt
import pandas as pd
from pathlib import Path
import psycopg2



#Creamos clase User
class User:
    def __init__(self, name, surname, email, genre, birth, phone, country, city, state):
        self.name = name
        self.surname = surname
        self.email = email
        self.genre = genre
        self.birth = birth
        self.phone = phone
        self.country = country
        self.city = city
        self.state = state

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


def users_lists():
    #Creamos una lista vacía para almacenar los usuarios
    users_list = []
    #Creamos la ruta relativa para acceder al archivo de usuarios
    base_path = Path(__file__).resolve().parent.parent
    csv_path = base_path / "users" / "extracted" / "users.csv"
    df = pd.read_csv(csv_path, sep=',')
    
    #Recorremos el DataFrame y creamos un objeto User por cada fila válida, luego lo añadimos a la lista
    for index, row in df.iterrows():
        if row.isna().any():
            continue  # Saltamos las filas con valores vacíos
        user = User(
            name=row['name'],
            surname=row['surname'],
            email=row['email'],
            genre=row['genre'],
            birth=row['birth'],
            phone=row['phone'],
            country=row['country'],
            city=row['city'],
            state=row['state']
        )
        users_list.append(user)
        
       
    return users_list    
     
def database_init_connection():
    try:
        #Creamos la conexión a la base de datos
        connection = psycopg2.connect(
            host="localhost",
            port=5432,
            database="proyecto0",
            user="postgres",
            password="1234"
        )
        print("Conexión a la base de datos establecida correctamente.")
        return connection
    except psycopg2.Error as e:
        print("Error al conectar a la base de datos:", e)
        return None

def database_insertion_query(db_connection, users):
    cursor = None
    try:
        #Creamos un cursor para ejecutar la consulta de inserción
        cursor = db_connection.cursor()
        insert_query = """
                        INSERT INTO users (name, surname, email, genre, birth, phone, country, city, state)
                        VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s)
                    """
        # Recorremos la lista de usuarios y ejecutamos la consulta de inserción para cada uno
        for user in users:
            
            datos_usuario = (
                user.name,
                user.surname,
                user.email,
                user.genre,
                user.birth,
                user.phone,
                user.country,
                user.city,
                user.state
            )
            cursor.execute(insert_query, datos_usuario)

        # Guardamos los cambios en la base de datos    
        db_connection.commit()
        print("Datos insertados correctamente en la base de datos.")

    # Manejamos un posible error
    except psycopg2.Error as e:
        print("Error al insertar datos en la base de datos:", e)
        if db_connection:
            db_connection.rollback()
    # Cerramos el cursor      
    finally:
        if cursor is not None:
            cursor.close()

    # Cerramos la conexión a la base de datos
        if db_connection is not None:
            db_connection.close()
            print("Conexión a la base de datos cerrada.")

obtener_fecha()
procesar_archivo()
users_lists()
database_init_connection()
database_insertion_query(database_init_connection(), users_lists())