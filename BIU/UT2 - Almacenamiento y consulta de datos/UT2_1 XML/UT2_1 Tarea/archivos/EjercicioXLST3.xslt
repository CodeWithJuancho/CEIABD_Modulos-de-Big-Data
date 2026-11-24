<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <xsl:output method="html" encoding="UTF-8" indent="yes"/>

  <xsl:template match="/">
    <html lang="es">
      <head>
        <meta charset="UTF-8"/>
        <title>Ciclos formativos del <xsl:value-of select="cifp/@nombre"/></title>
        <style>
body { font-family: Georgia, serif; margin: 2em auto; max-width: 46em; line-height: 1.5; color: #1f2328; }
h1, h2 { font-weight: normal; border-bottom: 1px solid #d0d7de; padding-bottom: .3em; }
h1 { margin-bottom: 1.5em; }
h2 { margin-top: 2em; }
ul { margin: 0; padding-left: 1.2em; }
li { margin-bottom: .3em; }
a { color: #0b5cad; }
</style>
      </head>
      <body>
        <h1><a href="{cifp/@web}"><xsl:value-of select="cifp/@nombre"/></a></h1>
        <p>Oferta de ciclos formativos del centro.</p>
        <xsl:apply-templates select="cifp/ciclos/ciclo"/>
      </body>
    </html>
  </xsl:template>

  <xsl:template match="ciclo">
    <h2><xsl:value-of select="nombre"/></h2>
    <p>
      El ciclo <xsl:value-of select="nombre"/> (<xsl:value-of select="@id"/>)
      pertenece al grado <xsl:value-of select="grado"/> y su título se estableció
      por el decreto del año <xsl:value-of select="decretoTitulo/@año"/>.
    </p>
    <p>Datos del ciclo:</p>
    <ul>
      <li><strong>Código:</strong><xsl:text> </xsl:text><xsl:value-of select="@id"/></li>
      <li><strong>Grado:</strong><xsl:text> </xsl:text><xsl:value-of select="grado"/></li>
      <li><strong>Año del decreto del título:</strong><xsl:text> </xsl:text><xsl:value-of select="decretoTitulo/@año"/></li>
    </ul>
  </xsl:template>
</xsl:stylesheet>
