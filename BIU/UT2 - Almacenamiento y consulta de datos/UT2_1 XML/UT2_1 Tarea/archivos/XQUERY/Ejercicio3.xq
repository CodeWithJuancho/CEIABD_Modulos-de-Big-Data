<libros_morgan_kaufmann>
{
    for $libro in doc("../EjercicioXQuery.xml")/bib/libro
    where contains($libro/editorial, "Morgan Kaufmann")
    return $libro
}
</libros_morgan_kaufmann>