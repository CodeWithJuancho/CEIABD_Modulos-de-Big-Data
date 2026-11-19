<libros_caros>
{
    for $libro in doc("EjercicioXQuery.xml")/bib/libro
    where xs:decimal($libro/precio) > 50
    order by xs:decimal($libro/precio) ascending
    return $libro
}
</libros_caros>