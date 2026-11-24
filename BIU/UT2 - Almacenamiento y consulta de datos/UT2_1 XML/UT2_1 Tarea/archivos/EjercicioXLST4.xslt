<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <xsl:output method="html" encoding="UTF-8" indent="yes"/>

  <xsl:template match="/">
    <html lang="es">
      <head>
        <meta charset="UTF-8"/>
        <title>Tabla de ciclos formativos</title>
        <style>
body { font-family: system-ui, sans-serif; margin: 2em; color: #1f2328; }
table { border-collapse: collapse; }
caption { text-align: left; font-size: 1.4em; margin-bottom: .8em; }
th, td { border: 1px solid #8c959f; padding: .4em .8em; text-align: left; }
th { background: #eaeef2; }
tbody tr:nth-child(even) { background: #f6f8fa; }
</style>
      </head>
      <body>
        <table>
          <caption>Ciclos formativos del <xsl:value-of select="cifp/@nombre"/></caption>
          <thead>
            <tr>
              <th>Código</th>
              <th>Nombre</th>
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
