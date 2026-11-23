<?xml version="1.0" encoding="UTF-8"?>
<!-- 1 Año del decreto del título
     Creen una plantilla XSLT que permita visualizar el año del decreto del título de cada ciclo formativo. -->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
  <xsl:template match="ciclo">
    <p><xsl:value-of select="nombre"/></p>
  </xsl:template>
</xsl:stylesheet>