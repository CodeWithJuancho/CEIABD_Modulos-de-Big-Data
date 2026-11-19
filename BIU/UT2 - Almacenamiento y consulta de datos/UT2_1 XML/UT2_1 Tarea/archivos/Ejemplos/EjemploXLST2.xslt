<?xml version="1.0" encoding="UTF-8"?>
<!-- Ejemplo de creación de una plantilla la cual, aplicada sobre el elemento libro, permite extraer el autor de cada uno de ellos. 
El resultado obtenido se corresponde con la frsae "AUTOR escribió TÍTULO" donde AUTOR y TÍTULO son los valores de los elementos correspondientes para cada libro-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <xsl:template match="libro">
    <p><xsl:value-of select="autor"/> escribió "<xsl:value-of select="titulo"/>"</p>
  </xsl:template>
</xsl:stylesheet>