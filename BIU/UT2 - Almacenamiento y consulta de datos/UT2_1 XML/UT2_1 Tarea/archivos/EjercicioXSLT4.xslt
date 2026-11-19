<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

  <xsl:template match="/">
    <html>
      <h1>Tabla de ciclos formativos</h1>
      <table border="1">
        <tr>
          <th>Identificador</th>
          <th>Nombre</th>
          <th>Grado</th>
          <th>Año Decreto</th>
        </tr>
        <xsl:for-each select="//ciclo">
          <tr>
            <td><xsl:value-of select="@id"/></td>
            <td><xsl:value-of select="nombre"/></td>
            <td><xsl:value-of select="grado"/></td>
            <td><xsl:value-of select="decretoTitulo/@año"/></td>
          </tr>
        </xsl:for-each>
      </table>
    </html>
  </xsl:template>

</xsl:stylesheet>
