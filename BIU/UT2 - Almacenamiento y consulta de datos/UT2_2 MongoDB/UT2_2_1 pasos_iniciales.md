************Instalación de MongoDB*************
Para MacOS con homebrew
https://www.mongodb.com/docs/v8.0/tutorial/install-mongodb-on-os-x/

brew tap mongodb/brew

brew trust mongodb/brew

brew install mongodb-community@8.0

Para Ubuntu con apt-get
https://www.mongodb.com/docs/v8.0/tutorial/install-mongodb-on-ubuntu/#std-label-install-mdb-community-ubuntu
************Instalado*************

**************COMANDOS***************
Iniciamos el servicio
~ brew services start mongodb-community@8.0

Paramos el servicio
~ brew services stop mongodb-community@8.0

Abrimos el motor de MongoDB 
~ mongosh

Creamos nuestra primera base de datos
> use CEIABD_BData

Eliminamos nuestra base de datos
> db.dropDatabase()

Comprobamos en qué base de datos estamos
> db

Creamos nuestra primera colección de datos
> db.createCollection("modulos")

Eliminamos nuestra colección de datos
> db.modulos.drop()

Mostramos todas las bds
> show dbs

Insertamos un registro
> db.modulos.insert({nombre:"MIA", dificultad:"media",matriculados:50})

Comprobamos que podemos volver a insertar el mismo registro
> db.modulos.insert({nombre:"MIA", dificultad:"media",matriculados:50})

Insertamos muchos registros con fallos entremedias (matricula dos)
> db.modulos.insertMany([{nombre:"SAA", dificultad:"media",matriculados:55},{nombre:"SBD",dificultad:"alta","matricula dos":70},{nombre:"BDA",dificultad:"alta" ,matriculados:60}])

Hacemos nuestra primera query 
> db.modulos.find()

Borramos un registros erróneos por un criterio especifico
> db.modulos.deleteOne({ nombre: 'SBD' });

Borramos varios registros erróneos por un criterio especifico
> db.modulos.deleteOne({ nombre: 'MIA' });

Los reinsertamos bien
> db.modulos.insertMany([{nombre:"MIA", dificultad:"media", matriculados:50}, {nombre:"SBD",dificultad:"alta",matriculados:70}])

Empezamos a buscar - ¿findOne() solo que devolverá? El primero
> db.modulos.findOne()

Filtramos
> db.modulos.findOne({ dificultad: "media" })

Filtramos la respuesta usando operadores condicionales
> db.modulos.find({matriculados:{$exist:true}})

Filtramos la respuesta usando operadores condicionales
> db.modulos.find({matriculados:{$gt:50}})

Mas operadores $and
> db.modulos.find({$and: [{matriculados:{$gt:50}}, {dificultad: "media"}]})

Mas operadores $or
> db.modulos.find({$or: [{matriculados:{$gt:50}}, {dificultad: "media"}]})

Mas operadores $and y $or anidado
> db.modulos.find({$and: [{matriculados:{$gt:50}}], $or: [{dificultad: "alta"},{dificultad: "media"}]})

Mas operadores $and y $or anidado
> db.modulos.find({$and: [{matriculados:{$lt:50}}], $or: [{dificultad: "alta"},{dificultad: "media"}]})

Mas operadores $or 
> db.modulos.find({$or: [{dificultad: "alta"},{dificultad: "media"}]})

Mas operadores expresiones regulares
> db.modulos.find({$and: [{matriculados:{$gt:50}}, {nombre:{$regex:".B"}}]})

Filtramos los datos de la respuesta con proyecciones y usamos operadores también
> db.modulos.find({matriculados:{$gt:50}}, {nombre:1, matriculados:2})

¿Filtramos los datos de la respuesta con cualquier cosa?
> db.modulos.find({matriculados:{$gt:50}}, {perro:1, matriculados:2})

Contamos el número de registros 
> db.modulos.countDocuments()

Contamos el número de registros filtrados
> db.modulos.countDocuments({nombre: "SAA"})

Ordenamos descendente
> db.modulos.find().sort({nombre: 1})

Ordenamos ascendente
> db.modulos.find().sort({nombre: -1}) 

Ordenamos y proyectamos descendente
> db.modulos.find({}, {nombre: 1}).sort({nombre: 1})

¿Y podemos proyectar y ordenar por otra etiqueta?
> db.modulos.find({}, {nombre: 1}).sort({matriculados: 1})

Ordenamos y proyectamos ascendente
> db.modulos.find({}, {nombre: 1}).sort({nombre: -1}) 

Limitamos los resultados que devuelven
> db.modulos.find({}, {nombre: 1}).sort({nombre: -1}).limit(2)

Nos saltamos valores desde el inicio de la respuesta
> db.modulos.find({}, {nombre: 1}).sort({nombre: -1}).limit(2).skip(2)

Actualizar un registro
> db.modulos.update({nombre: "SAA"}, {$set: nombre: "TEST"}})

Actualizar el esquema de un registro
> db.modulos.updateOne({nombre: "TEST"}, {$set: { nombre: {acronimo: "SAA",  nombreCompleto:"Sistemas de Aprendizaje Automático"}}})

Presentamos por pantalla a ver qué sale
> db.modulos.find()

¿Cómo encuentro ahora este registro?
> db.modulos.find({nombre: {acronimo: "SAA"}}) - NOPE
> db.modulos.find({nombre.acronimo: "SAA"}) - NOPE

Busca una coincidencia exacta de todo el subdocumento nombre
> db.modulos.find({nombre: {acronimo: "SAA", nombreCompleto:"Sistemas de Aprendizaje Automático"}}) - YES

Busca de manera anidada dentro de los elementos
> db.modulos.find({"nombre.acronimo": "SAA"}) - YES

Conocer la URI de nuestra base de datos
> db.getMongo().getURI()

*********MongoDB Tools on ubuntu********************
The MongoDB Database Tools are a collection of command-line utilities for working with a MongoDB deployment, including data backup and import/export tools like mongoimport and mongodump as well as monitoring tools like mongotop

*Database import and export*
@TODO

*Monitoring tool*
~ sudo apt-get update && sudo apt-get install -y mongodb-database-tools
