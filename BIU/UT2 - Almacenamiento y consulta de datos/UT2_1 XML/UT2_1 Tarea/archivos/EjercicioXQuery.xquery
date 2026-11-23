xquery version "3.1";
declare option output:indent "yes";
declare option db:stripws "true";

(: 1 Libros con precio superior a cincuenta euros
Creen una consulta XQuery para recuperar todos los libros cuyo precio sea mayor que cincuenta euros. Muestren los resultados ordenados por precio. :)

(: 
<libros>
{
    for $libro in doc("EjercicioXQuery.xml")/bib/libro
    where xs:decimal($libro/precio) > 50
    order by xs:decimal($libro/precio) ascending
    return $libro
}
</libros>
:)

(: 2 Libros con varios autores
Creen una consulta XQuery para recuperar todos los libros que hayan sido escritos por más de un autor. Muestren los resultados ordenados por el año de publicación del libro. :)

(: 
<libros>
{ 
    for $libro in doc("EjercicioXQuery.xml")/bib/libro
    where count($libro/autor) > 1
    order by $libro/@ano ascending
    return $libro
}
</libros>
:)

(: 3 Libros de una editorial
Creen una consulta XQuery para mostrar todos los libros de la editorial Morgan Kaufmann. :)

(: 
<libros>
{
    for $libro in doc("EjercicioXQuery.xml")/bib/libro
    where $libro/editorial = "Morgan Kaufmann editorials"
    return $libro
}
</libros>
:)

(: 4 Libros y autores
Creen una consulta XQuery para mostrar todos los libros y sus autores. Si un libro tiene más de un autor, muestren el primero de ellos seguido de «y otros». :)

(: 
<libros>
{
    for $libro in doc("EjercicioXQuery.xml")/bib/libro
    return <libro>{'"' || normalize-space($libro/titulo) || '"' || 
        (if (count($libro/autor) > 0) then (" de " || data($libro/autor[1]/nombre) || " " || data($libro/autor[1]/apellido)) else "") ||
        (if (count($libro/autor) > 1) then (" y otros") else "")
    }</libro>
}
</libros>
:)

(: 5 Libros de programación
Creen una consulta XQuery para mostrar todos los libros de programación, es decir, aquellos que contengan la palabra «programming» en su título. :)


<libros>
{
    for $libro in doc("EjercicioXQuery.xml")/bib/libro
    where contains(lower-case($libro/titulo), "programming")
    return $libro
}
</libros>



