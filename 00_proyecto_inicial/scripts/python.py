from datetime import datetime
import pandas as pd

fecha = datetime.now().strftime("%d_%m_%y")
print(fecha)

class User:
    def __init__(self, name, surname, email, genre, birth,
                 phone, country, city, state):
        self.name = name
        self.surname = surname
        self.email = email
        self.genre = genre
        self.birth = birth
        self.phone = phone
        self.country = country
        self.city = city
        self.state = state

df = pd.read_csv("../users/extracted/users.csv",
                 na_values=["", " ", "N/A", "null"])

imported_rows = []
rejected_rows = []
users = []

for indice, fila in df.iterrows():
    texto = ",".join(fila.fillna("").astype(str))
    if fila.isna().any():
        rejected_rows.append(texto)
    else:
        imported_rows.append(texto)
        users.append(User(
            fila["name"], fila["surname"], fila["email"],
            fila["genre"], fila["birth"], fila["phone"],
            fila["country"], fila["city"], fila["state"],
        ))

with open(f"../logs/{fecha}_rejected_rows.txt", "w", encoding="utf-8") as f:
    f.write(f"There were {len(rejected_rows)} rejected rows.\n")
    f.write("\n".join(rejected_rows) + "\n")

with open(f"../logs/{fecha}_imported_rows.txt", "w", encoding="utf-8") as f:
    f.write(f"There were {len(imported_rows)} imported rows.\n")
    f.write("\n".join(imported_rows) + "\n")