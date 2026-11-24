*********Ejemplo de restaurantes.csv con MongoDB********************
Importar el archivo restaurantes1.csv - Fuera de mongosh
~ mongoimport --db restaurantes_db --collection restaurantes --file ./Proyecto/CE_IABD_BIU_SPS/BIU/UT2\ -\ Almacenamiento\ y\ consulta\ de\ datos/UT2_2\ MongoDB/Tarea\ UT2_2/Ejemplo/restaurantes1.csv


Crear una consultar para encontrar qué restaurantes no tienen dirección
> 

Crear una consulta para encontrar aquellos restaurantes de cocina italiana que se encuentren en la zona geográfica con código postal 10075
> db.restaurantes.find({$and: [{"address.zipcode":"10075"}, {cuisine: "Italian"}]})

Encontrar aquellos restaurantes que tengan grado A, puntuación 11 y fecha 2014-10-01T00:00:00Z
>  db.restaurantes.find({$and: [{"grades.grade":"A"}, {"grades.score": 11}, {"grades.date": ISODate('2014-10-01T00:00:00Z')}]})


Contabiliza cuántos restaurantes tienen una puntuación menor o igual a 5
> db.restaurantes.count({"grades.score": {$lte:5}})


Obtener los nombres del segundo y el tercer restaurante de cocina italiana ordenados por nombre
> 

Añadir una valoración al restaurante 41156888
> 
