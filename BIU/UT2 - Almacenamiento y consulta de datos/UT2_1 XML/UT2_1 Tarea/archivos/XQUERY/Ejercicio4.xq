<catalogo>
{
    for $libro in /bib/libro
    return
    <libro>
        {$libro/titulo}
        {
            if (count($libro/autor) > 1) then
            (
                $libro/autor[1],
                <autores_adicionales>y otros</autores_adicionales>
            )
            else if (count($libro/autor) = 1) then
                $libro/autor
            else ()
        }
    </libro>
}
</catalogo>