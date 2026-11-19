<?xml version="1.0" encoding="UTF-8"?>
<!-- Ejemplo en el que se aplica una plantilla desde el nodo raíz. 
El resultado es la construcción de un archivo HTML en el que se incluye un título con un encabezado de tamaño grande llamado "Autores". 
A continuación, se aplican todas las plantillas que sea posible aplicar de forma recursiva. 
De esta forma, se recuperan los valores de los autores de cada libro, englobados dentro de respectivas etiquetas de párrafo -->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <xsl:template match="/">
    <html>
      <h1>Autores</h1>
      <xsl:apply-templates />
    </html>
  </xsl:template>
  <xsl:template match="libro">
     <p><xsl:value-of select="autor"/></p>
  </xsl:template>
</xsl:stylesheet>