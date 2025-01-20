<!--
####################################################################
#
# lfs-pkglist.xsl
#
####################################################################
-->

<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:output method="xml" />


<!--
####################################################################
# ROOT
####################################################################
-->
<xsl:template match="/">
	<book>
		<xsl:apply-templates select="//chapter[@id='chapter-building-system']//sect1info" />
	</book>
</xsl:template>


<!--
####################################################################
# CHAPTER
####################################################################
-->
<xsl:template match="sect1info">

	<xsl:text>&#xA;</xsl:text>
	<package>
		<id><xsl:value-of select="productname" /></id>
                <version>$$version-<xsl:value-of select="productnumber" />$$</version>
        </package>

</xsl:template>



</xsl:stylesheet>
