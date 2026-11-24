<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <xsl:output method="html" encoding="UTF-8" indent="yes"/>

  <xsl:template match="/">
    <html lang="es">
      <head>
        <meta charset="UTF-8"/>
        <title>Año del decreto del título</title>
      </head>
      <body>
        <h1>Año del decreto del título</h1>
        <xsl:apply-templates select="cifp/ciclos/ciclo"/>
      </body>
    </html>
  </xsl:template>

  <xsl:template match="ciclo">
    <p><xsl:value-of select="@id"/>: <xsl:value-of select="decretoTitulo/@año"/></p>
  </xsl:template>
</xsl:stylesheet>
