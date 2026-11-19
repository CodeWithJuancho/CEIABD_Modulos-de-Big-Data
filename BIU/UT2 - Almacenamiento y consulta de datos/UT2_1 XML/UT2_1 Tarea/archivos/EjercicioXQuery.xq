(: ================================================================= :)
(: 1. Libros con precio superior a cincuenta euros                   :)
(: ================================================================= :)
(:
for $b in doc("EjercicioXQuery.xml")//bib/libro
where xs:decimal($b/precio) > 50
order by xs:decimal($b/precio)
return $b
:)

(: ================================================================= :)
(: 2. Libros con varios autores ordenados por año                    :)
(: ================================================================= :)
(:
for $b in doc("EjercicioXQuery.xml")//bib/libro
where count($b/autor) > 1
order by xs:integer($b/@ano)
return $b
:)

(: ================================================================= :)
(: 3. Libros de una editorial (Morgan Kaufmann)                      :)
(: ================================================================= :)
(:
for $b in doc("EjercicioXQuery.xml")//bib/libro
where contains($b/editorial, "Morgan Kaufmann")
return $b
:)

(: ================================================================= :)
(: 4. Libros y autores (el primero seguido de 'y otros')             :)
(: ================================================================= :)
for $b in doc("EjercicioXQuery.xml")//bib/libro
return
  <libro>
    { $b/titulo }
    {
      if (count($b/autor) > 1)
      then <autor>{concat($b/autor[1]/nombre, " ", $b/autor[1]/apellido, " y otros")}</autor>
      else
        for $a in $b/autor
        return <autor>{concat($a/nombre, " ", $a/apellido)}</autor>
    }
  </libro>

(: ================================================================= :)
(: 5. Libros de programación                                         :)
(: ================================================================= :)
(:
for $b in doc("EjercicioXQuery.xml")//bib/libro
where contains(lower-case($b/titulo), "programming")
return $b
:)
