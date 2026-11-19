<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:output method="html" encoding="UTF-8" indent="yes"/>

  <xsl:template match="/">
    <html>
      <head>
        <title>Lista de los ciclos formativos</title>
      </head>
      <body>
        <h1>Ciclos Formativos - <xsl:value-of select="cifp/@nombre"/></h1>
        <ul>
          <xsl:for-each select="cifp/ciclos/ciclo">
            <li><xsl:value-of select="nombre"/></li>
          </xsl:for-each>
        </ul>
      </body>
    </html>
  </xsl:template>           
</xsl:stylesheet>