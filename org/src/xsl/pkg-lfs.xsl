<!--
####################################################################
#
# pkg-lfs.xsl
#
####################################################################
-->

<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:output method="xml" />


<!--
####################################################################
#
####################################################################
-->
<xsl:template match="/">
	<book>
		<xsl:apply-templates select="//chapter[@id='chapter-building-system']//productname" />
	<xsl:text>&#xA;</xsl:text>
	</book>
</xsl:template>


<!--
####################################################################
# CHAPTER
####################################################################
-->
<xsl:template match="productname">

	<xsl:text>&#xA;</xsl:text>
	<package>
		<id><xsl:value-of select="." /></id>
		<version><xsl:value-of select="following-sibling::productnumber" /></version>
	</package>

</xsl:template>




</xsl:stylesheet>
