<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <xsl:output method="html" encoding="UTF-8" indent="yes"/>

  <xsl:template match="/">
    <html lang="es">
      <head>
        <meta charset="UTF-8"/>
        <title>Ciclos formativos</title>
      </head>
      <body>
        <h1>Ciclos formativos</h1>
        <ul>
          <xsl:for-each select="cifp/ciclos/ciclo">
            <li><xsl:value-of select="nombre"/></li>
          </xsl:for-each>
        </ul>
      </body>
    </html>
  </xsl:template>
</xsl:stylesheet>
