# Instalación de MongoDB

## Para MacOS con homebrew

<https://www.mongodb.com/docs/v8.0/tutorial/install-mongodb-on-os-x/>

```bash
brew tap mongodb/brew
brew trust mongodb/brew
brew install mongodb-community@8.0
```

## Para Ubuntu con apt-get

<https://www.mongodb.com/docs/v8.0/tutorial/install-mongodb-on-ubuntu/#std-label-install-mdb-community-ubuntu>

**Instalado**

## MongoDB Tools on ubuntu

The MongoDB Database Tools are a collection of command-line utilities for working with a MongoDB deployment, including data backup and import/export tools like mongoimport and mongodump as well as monitoring tools like mongotop

```bash
sudo apt-get update && sudo apt-get install -y mongodb-database-tools
```

### Monitoring tool

```bash
mongotop
```

## COMANDOS EN MACOS CON BREW

### Iniciamos el servicio

```bash
brew services start mongodb-community@8.0
```

**Paramos el servicio**

```bash
brew services stop mongodb-community@8.0
```

## COMANDOS EN MONGODB

**Abrimos el motor de MongoDB**

```bash
mongosh
```

### Creamos nuestra primera base de datos

```javascript
use CEIABD_BData
```

**Eliminamos nuestra base de datos**

```javascript
db.dropDatabase()
```

**Comprobamos en qué base de datos estamos**

```javascript
db
```

**Creamos nuestra primera colección de datos**

```javascript
db.createCollection("modulos")
```

**Eliminamos nuestra colección de datos**

```javascript
db.modulos.drop()
```

**Mostramos todas las bds**

```javascript
show dbs
```

### Insertamos un registro

```javascript
db.modulos.insert({nombre:"MIA", dificultad:"media",matriculados:50})
```

**Comprobamos que podemos volver a insertar el mismo registro**

```javascript
db.modulos.insert({nombre:"MIA", dificultad:"media",matriculados:50})
```

**Insertamos muchos registros con fallos entremedias (matricula dos)**

```javascript
db.modulos.insertMany([
  {nombre:"SAA", dificultad:"media",matriculados:55},
  {nombre:"SBD",dificultad:"alta","matricula dos":70},
  {nombre:"BDA",dificultad:"alta" ,matriculados:60}
])
```

**Hacemos nuestra primera query**

```javascript
db.modulos.find()
```

**Borramos un registros erróneos por un criterio especifico**

```javascript
db.modulos.deleteOne({ nombre: 'SBD' });
```

**Borramos varios registros erróneos por un criterio especifico**

```javascript
db.modulos.deleteOne({ nombre: 'MIA' });
```

**Los reinsertamos bien**

```javascript
db.modulos.insertMany([
  {nombre:"MIA", dificultad:"media", matriculados:50},
  {nombre:"SBD",dificultad:"alta",matriculados:70}
])
```

### Empezamos a buscar - ¿findOne() solo que devolverá? El primero

```javascript
db.modulos.findOne()
```

**Filtramos**

```javascript
db.modulos.findOne({ dificultad: "media" })
```

**Filtramos la respuesta usando operadores condicionales**

```javascript
db.modulos.find({matriculados:{$exist:true}})
```

**Filtramos la respuesta usando operadores condicionales**

```javascript
db.modulos.find({matriculados:{$gt:50}})
```

**Mas operadores `$and`**

```javascript
db.modulos.find({$and: [{matriculados:{$gt:50}}, {dificultad: "media"}]})
```

**Mas operadores `$or`**

```javascript
db.modulos.find({$or: [{matriculados:{$gt:50}}, {dificultad: "media"}]})
```

**Mas operadores `$and` y `$or` anidado**

```javascript
db.modulos.find({
  $and: [{matriculados:{$gt:50}}],
  $or: [{dificultad: "alta"},{dificultad: "media"}]
})
```

**Mas operadores `$and` y `$or` anidado**

```javascript
db.modulos.find({
  $and: [{matriculados:{$lt:50}}],
  $or: [{dificultad: "alta"},{dificultad: "media"}]
})
```

**Mas operadores `$or`**

```javascript
db.modulos.find({$or: [{dificultad: "alta"},{dificultad: "media"}]})
```

**Mas operadores expresiones regulares**

```javascript
db.modulos.find({$and: [{matriculados:{$gt:50}}, {nombre:{$regex:".B"}}]})
```

### Filtramos los datos de la respuesta con proyecciones y usamos operadores también

```javascript
db.modulos.find({matriculados:{$gt:50}}, {nombre:1, matriculados:2})
```

**¿Filtramos los datos de la respuesta con cualquier cosa?**

```javascript
db.modulos.find({matriculados:{$gt:50}}, {perro:1, matriculados:2})
```

### Contamos el número de registros

```javascript
db.modulos.countDocuments()
```

**Contamos el número de registros filtrados**

```javascript
db.modulos.countDocuments({nombre: "SAA"})
```

### Ordenamos descendente

```javascript
db.modulos.find().sort({nombre: 1})
```

**Ordenamos ascendente**

```javascript
db.modulos.find().sort({nombre: -1})
```

**Ordenamos y proyectamos descendente**

```javascript
db.modulos.find({}, {nombre: 1}).sort({nombre: 1})
```

**¿Y podemos proyectar y ordenar por otra etiqueta?**

```javascript
db.modulos.find({}, {nombre: 1}).sort({matriculados: 1})
```

**Ordenamos y proyectamos ascendente**

```javascript
db.modulos.find({}, {nombre: 1}).sort({nombre: -1})
```

### Limitamos los resultados que devuelven

```javascript
db.modulos.find({}, {nombre: 1}).sort({nombre: -1}).limit(2)
```

**Nos saltamos valores desde el inicio de la respuesta**

```javascript
db.modulos.find({}, {nombre: 1}).sort({nombre: -1}).limit(2).skip(2)
```

### Actualizar un registro

```javascript
db.modulos.update({nombre: "SAA"}, {$set: nombre: "TEST"}})
```

**Actualizar el esquema de un registro**

```javascript
db.modulos.updateOne(
  {nombre: "TEST"},
  {
    $set: {
      nombre: {acronimo: "SAA",  nombreCompleto:"Sistemas de Aprendizaje Automático"}
    }
  }
)
```

**Presentamos por pantalla a ver qué sale**

```javascript
db.modulos.find()
```

### ¿Cómo encuentro ahora este registro?

```javascript
db.modulos.find({nombre: {acronimo: "SAA"}})
```

**- NOPE**

```javascript
db.modulos.find({nombre.acronimo: "SAA"})
```

**- NOPE**

**Busca una coincidencia exacta de todo el subdocumento nombre**

```javascript
db.modulos.find({
  nombre: {acronimo: "SAA", nombreCompleto:"Sistemas de Aprendizaje Automático"}
})
```

**- YES**

**Busca de manera anidada dentro de los elementos**

```javascript
db.modulos.find({"nombre.acronimo": "SAA"})
```

**- YES**

### Conocer la URI de nuestra base de datos

```javascript
db.getMongo().getURI()
```