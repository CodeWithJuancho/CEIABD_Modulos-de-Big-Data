<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:output method="html" encoding="UTF-8" indent="yes"/>
    <xsl:template match="/">
        <html>
            <body>
                <!-- Aqui se lee los datos y recorre los nodos con XPATH -->
                <ul>
                <xsl:for-each select="cifp/ciclos/ciclo">
                    <li><xsl:value-of select="@id"></xsl:value-of></li>
                    <li><xsl:value-of select="nombre"></xsl:value-of></li>
                    <li><xsl:value-of select="decretoTitulo/@año"></xsl:value-of></li>
                </xsl:for-each>
                </ul>
            </body>
        </html>
    </xsl:template>
</xsl:stylesheet>