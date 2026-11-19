<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

  <xsl:template match="/">
    <html>
      <h1>Año del decreto del título</h1>
      <xsl:apply-templates select="//ciclo"/>
    </html>
  </xsl:template>

  <xsl:template match="ciclo">
    <p><xsl:value-of select="nombre"/>: <xsl:value-of select="decretoTitulo/@año"/></p>
  </xsl:template>

</xsl:stylesheet>
