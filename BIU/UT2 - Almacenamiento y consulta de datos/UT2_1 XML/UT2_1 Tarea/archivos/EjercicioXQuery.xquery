xquery version "3.1";

(: 1 Libros con precio superior a cincuenta euros
Creen una consulta XQuery para recuperar todos los libros cuyo precio sea mayor que cincuenta euros. Muestren los resultados ordenados por precio. :)

(: 
for $libro in doc("EjercicioXQuery.xml")/bib/libro
where $libro/precio > 50
order by($libro/precio)
return $libro
:)

(: 2 Libros con varios autores
Creen una consulta XQuery para recuperar todos los libros que hayan sido escritos por más de un autor. Muestren los resultados ordenados por el año de publicación del libro. :)

(: 
for $libro in doc("EjercicioXQuery.xml")/bib/libro
where count($libro/autor) > 1
order by($libro/@ano)
return $libro
:)

(: 3 Libros de una editorial
Creen una consulta XQuery para mostrar todos los libros de la editorial Morgan Kaufmann. :)

(: 
for $libro in doc("EjercicioXQuery.xml")/bib/libro
where $libro/editorial = "Morgan Kaufmann editorials"
return $libro
:)

(: 4 Libros y autores
Creen una consulta XQuery para mostrar todos los libros y sus autores. Si un libro tiene más de un autor, muestren el primero de ellos seguido de «y otros». :)

(: 
for $libro in doc("EjercicioXQuery.xml")/bib/libro
return '"' || normalize-space($libro/titulo) || '"' || 
    (if (count($libro/autor) > 0) then (" de " || data($libro/autor[1]/nombre) || " " || data($libro/autor[1]/apellido)) else "") ||
    (if (count($libro/autor) > 1) then (" y otros") else "")
:)

(: 5 Libros de programación
Creen una consulta XQuery para mostrar todos los libros de programación, es decir, aquellos que contengan la palabra «programming» en su título. :)


for $libro in doc("EjercicioXQuery.xml")/bib/libro
where contains(lower-case($libro/titulo), "programming")
return $libro


