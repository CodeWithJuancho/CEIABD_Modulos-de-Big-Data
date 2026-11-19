<?xml version="1.0" encoding="UTF-8"?>
<!-- Ejemplo en el que se aplica una plantilla sobre el elemento libro de forma que para cada uno de ellos, se selecciona el autor del mismo. 
El resultado mostrado corresponde con los autores de cada uno de los libros, englobados entre etiquetas de párrafo <p> html --> 
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <xsl:template match="libro">
     <p><xsl:value-of select="autor"/></p>
  </xsl:template>
</xsl:stylesheet>