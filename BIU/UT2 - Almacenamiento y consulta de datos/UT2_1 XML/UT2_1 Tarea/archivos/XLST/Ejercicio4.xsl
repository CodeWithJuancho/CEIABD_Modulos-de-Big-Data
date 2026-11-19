<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:output method="html" encoding="UTF-8" indent="yes"/>

  <xsl:template match="/">
    <html>
      <head>
        <title>Tabla de ciclos formativos</title>
      </head>
      <body>
        <h1>Ofertas de ciclos formativos (<xsl:value-of select="cifp/@nombre"/>)</h1>
        <table border="1" cellpadding="8" cellspacing="0">
          <thead>
            <tr>
              <th>ID</th>
              <th>Nombre del ciclo</th>
              <th>Grado</th>
              <th>Año del decreto</th>
            </tr>
          </thead>
          <tbody>
            <xsl:for-each select="cifp/ciclos/ciclo">
              <tr>
                <td><xsl:value-of select="@id"/></td>
                <td><xsl:value-of select="nombre"/></td>
                <td><xsl:value-of select="grado"/></td>
                <td><xsl:value-of select="decretoTitulo/@año"/></td>
              </tr>
            </xsl:for-each>
          </tbody>
        </table>
      </body>
    </html>
  </xsl:template>
</xsl:stylesheet>