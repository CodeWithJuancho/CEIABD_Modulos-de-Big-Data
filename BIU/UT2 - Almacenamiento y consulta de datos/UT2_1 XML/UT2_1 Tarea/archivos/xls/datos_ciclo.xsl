<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:output method="html" encoding="UTF-8" indent="yes"/>
    <xsl:template match="/">
        <!-- mostrar los datos de cada ciclo formativo -->
        <html>
            <head>
                <title>Ciclos Formativos - <xsl:value-of select="cifp/@nombre"></xsl:value-of></title>
            </head>
            <body>
                <h1><xsl:value-of select="cifp/@nombre"></xsl:value-of></h1>

                <xsl:for-each select="cifp/ciclos/ciclo">
                    <div>
                        <h2><xsl:value-of select="nombre"></xsl:value-of></h2>
                        <p>Código del ciclo: <xsl:value-of select="@id"></xsl:value-of></p>
                        <ul>
                            <li>Grado: <xsl:value-of select="grado"></xsl:value-of></li>
                            <li>Año del decreto del titulo: <xsl:value-of select="decretoTitulo/@año"></xsl:value-of></li>
                        </ul>
                    </div>
                    </xsl:for-each>
            </body>
        </html>
    </xsl:template>
</xsl:stylesheet>