<libros_varios_autores>
{
    for $libro in doc("../EjercicioXQuery.xml")/bib/libro
    where count($libro/autor) > 1
    order by xs:integer($libro/@ano) ascending
    return $libro
}
</libros_varios_autores>