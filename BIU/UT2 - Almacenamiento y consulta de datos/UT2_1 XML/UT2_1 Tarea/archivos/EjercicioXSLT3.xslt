<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

  <xsl:template match="/">
    <html>
      <h1>Datos de los ciclos formativos</h1>
      <xsl:for-each select="//ciclo">
        <h2><xsl:value-of select="nombre"/> (<xsl:value-of select="@id"/>)</h2>
        <p>Grado: <xsl:value-of select="grado"/></p>
        <p>Año del decreto: <xsl:value-of select="decretoTitulo/@año"/></p>
        <ul>
          <li>Identificador: <xsl:value-of select="@id"/></li>
          <li>Grado formativo: <xsl:value-of select="grado"/></li>
          <li>Año del título: <xsl:value-of select="decretoTitulo/@año"/></li>
        </ul>
      </xsl:for-each>
    </html>
  </xsl:template>

</xsl:stylesheet>
