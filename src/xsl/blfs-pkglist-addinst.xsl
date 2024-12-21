<!--
####################################################################
#
# blfs-pkglist-addinst.xsl
#
####################################################################
-->

<xsl:stylesheet version="1.0"
        xmlns:xsl="http://www.w3.org/1999/XSL/Transform">



<xsl:output method="xml" />
<xsl:strip-space elements="*" />

<xsl:param name="name" />
<xsl:param name="version" />


<!--
####################################################################
# IDENTITY TRANSFORM
####################################################################
-->
<xsl:template match="@* | node()">
	
	<xsl:copy>
		<xsl:apply-templates select="@* | node()"/>
	</xsl:copy>

</xsl:template>
<!--
####################################################################
# ADD INSTALLED
####################################################################
-->

<xsl:template match="//package">
	
	<package>
		<!-- Use %% for exact match -->
		<xsl:variable name="id-test" select="concat('%',id,'%')" />
		<xsl:variable name="name-test" select="concat('%',$name,'%')" />
		<xsl:variable name="match" select="id" />
		<xsl:choose>
			<xsl:when test="contains($name-test,$id-test)">

				<xsl:copy-of select="id"/>
				<xsl:copy-of select="version"/>
				<installed><xsl:value-of select="$version" /></installed>

			</xsl:when>

			<xsl:otherwise>
				<xsl:copy-of select="./*"/>
			</xsl:otherwise>
		</xsl:choose>
	</package>
	<xsl:text>&#xA;</xsl:text>

</xsl:template>





</xsl:stylesheet>
