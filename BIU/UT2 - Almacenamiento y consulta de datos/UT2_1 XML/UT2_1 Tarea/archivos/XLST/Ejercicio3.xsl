<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:output method="html" encoding="UTF-8" indent="yes"/>

  <xsl:template match="/"> 
    <html>
      <head>
        <title>Presentación de los ciclos formativos</title>
      </head>
      <body>
        <h1><xsl:value-of select="cifp/@nombre"/></h1>
        <p>Web oficial: <a href="{cifp/@web}"><xsl:value-of select="cifp/@web"/></a></p>

        <xsl:for-each select="cifp/ciclos/ciclo">
          <h2><xsl:value-of select="nombre"/> (<xsl:value-of select="@id"/>)</h2>
          <p>Información detallada del ciclo formativo</p>
          <ul>
            <li><strong>Código:</strong> <xsl:value-of select="@id"/></li>
            <li><strong>Grado:</strong> <xsl:value-of select="grado"/></li>
            <li><strong>Año del decreto:</strong> <xsl:value-of select="decretoTitulo/@año"/></li>
          </ul>
        </xsl:for-each>
      </body>
    </html>
  </xsl:template>
</xsl:stylesheet>