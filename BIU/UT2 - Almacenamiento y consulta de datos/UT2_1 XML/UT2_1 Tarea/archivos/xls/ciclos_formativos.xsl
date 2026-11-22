<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:output method="html" encoding="UTF-8" indent="yes"/>
    <xsl:template match="/">
        <html>
            <body>
                <!-- Mostrar todos los datos de cada ciclo formativo con una presentacion cuidada, utilizando encabezados, párrafos y listas -->
                <ul>
                    <xsl:for-each select="cifp/ciclos/ciclo">
                        <li><xsl:value-of select="nombre"></xsl:value-of></li>
                    </xsl:for-each>
                </ul>
            </body>
        </html>
    </xsl:template>
</xsl:stylesheet>