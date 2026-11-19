<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:output method="html" encoding="UTF-8" indent="yes"/>

  <xsl:template match="/">
    <html>
      <head>
        <title>Año del decreto del título</title>
      </head>
      <body>
        <h1>Año del decreto de los cilos formativos</h1>
        <xsl:for-each select="cifp/ciclos/ciclo">
          <p>
            Año <strong><xsl:value-of select="nombre"/>:</strong>
          </p>
        </xsl:for-each>
      </body>
    </html>
  </xsl:template>
</xsl:stylesheet>