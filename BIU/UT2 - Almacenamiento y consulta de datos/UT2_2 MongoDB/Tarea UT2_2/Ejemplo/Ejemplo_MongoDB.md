*********Ejemplo de restaurantes.csv con MongoDB********************
Importar el archivo restaurantes1.csv - Fuera de mongosh
~ mongoimport --db CEIABD_BData --collection restaurantes --file restaurantes1.csv

Crear una consultar para encontrar qué restaurantes no tienen dirección
> db.restaurantes.find({ address: { $exists: false } })

Crear una consulta para encontrar aquellos restaurantes de cocina italiana que se encuentren en la zona geográfica con código postal 10075
> db.restaurantes.find({ cuisine: "Italian", "address.zipcode": "10075" })

Encontrar aquellos restaurantes que tengan grado A, puntuación 11 y fecha 2014-10-01T00:00:00Z
> db.restaurantes.find({ grades: { $elemMatch: { grade: "A", score: 11, date: ISODate("2014-10-01T00:00:00Z") } } })

Contabiliza cuántos restaurantes tienen una puntuación menor o igual a 5
> db.restaurantes.countDocuments({ "grades.score": { $lte: 5 } })

Obtener los nombres del segundo y el tercer restaurante de cocina italiana ordenados por nombre
> db.restaurantes.find({ cuisine: "Italian" }, { name: 1, _id: 0 }).sort({ name: 1 }).skip(1).limit(2)

Añadir una valoración al restaurante 41156888
> db.restaurantes.updateOne({ restaurant_id: "41156888" }, { $push: { grades: { date: new Date(), grade: "A", score: 10 } } })


