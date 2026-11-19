<libros_programacion>
{
    for $libro in doc("../EjercicioXQuery.xml")/bib/libro
    where contains(lower-case($libro/titulo), "programming")
    return $libro
}
</libros_programacion>