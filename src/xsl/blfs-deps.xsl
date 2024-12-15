<!--
####################################################################
#
# DEPENDENCIES XSL
#
####################################################################
-->

<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:exsl="http://exslt.org/common"
    	extension-element-prefixes="exsl">


<xsl:output method="text" />
<xsl:strip-space elements="*" />

<xsl:param name="package" />
<xsl:param name="required" />
<xsl:param name="recommended" />
<xsl:param name="optional" />
<xsl:param name="files" />
<xsl:param name="depsdir" />


<!--
####################################################################
# ROOT
####################################################################
-->
<xsl:template match="/">

	<xsl:choose>
		<!-- create files -->
		<xsl:when test="not($files='')">
			<xsl:apply-templates select="//sect1[@id]" mode="files" />
			<xsl:apply-templates select="//sect2[@id]" mode="files" />
		</xsl:when>
		<xsl:otherwise>
			<xsl:apply-templates select="//sect1[@id=$package]" />
                        <xsl:apply-templates select="//sect2[@id=$package]" />
		</xsl:otherwise>
	</xsl:choose>
			

</xsl:template>

<!--
####################################################################
# SECT1 SECT2
####################################################################
-->
<xsl:template match="sect1|sect2">

	<!-- REQUIRED -->
	<xsl:if test="string($required) = 'true'">
		<xsl:apply-templates select=".//para[@role='required']" />
	</xsl:if>

	<!-- RECOMMENDED -->
	<xsl:if test="$recommended = 'true'">
		<xsl:apply-templates select=".//para[@role='recommended']" />
	</xsl:if>

	<!-- OPTIONAL -->
	<xsl:if test="$optional = 'true'">
		<xsl:apply-templates select=".//para[@role='optional']" />
	</xsl:if>


</xsl:template>

<!--
####################################################################
# SECT1 SECT2 CREATE FILES
####################################################################
-->
<xsl:template match="sect1|sect2" mode="files">

	<xsl:variable name="create-file" select="concat($depsdir,@id,'.deps')" />
	<xsl:text>Creating </xsl:text>
	<xsl:value-of select="$create-file" />
	<xsl:text>...</xsl:text>
	<xsl:text>&#xA;</xsl:text>

        <exsl:document href="{$create-file}" method="text">
		
        	<!-- REQUIRED -->
        	<xsl:if test="string($required) = 'true'">
        		<xsl:apply-templates select=".//para[@role='required']" />
        	</xsl:if>

        	<!-- RECOMMENDED -->
        	<xsl:if test="$recommended = 'true'">
        		<xsl:apply-templates select=".//para[@role='recommended']" />
        	</xsl:if>

        	<!-- OPTIONAL -->
        	<xsl:if test="$optional = 'true'">
        		<xsl:apply-templates select=".//para[@role='optional']" />
        	</xsl:if>

		<!-- SELF -->
		<xsl:text>--</xsl:text><xsl:value-of select="@id" /><xsl:text>--</xsl:text>
		<xsl:text>&#xA;</xsl:text>

		<!-- RUNTIME -->
        	<!-- REQUIRED -->
        	<xsl:if test="string($required) = 'true'">
        		<xsl:apply-templates select=".//para[@role='required']" mode="runtime" />
        	</xsl:if>

        	<!-- RECOMMENDED -->
        	<xsl:if test="$recommended = 'true'">
        		<xsl:apply-templates select=".//para[@role='recommended']" mode="runtime" />
        	</xsl:if>

        	<!-- OPTIONAL -->
        	<xsl:if test="$optional = 'true'">
        		<xsl:apply-templates select=".//para[@role='optional']" mode="runtime" />
        	</xsl:if>
	
	</exsl:document>

</xsl:template>



<!--
####################################################################
# PARA
####################################################################
-->
<xsl:template match="para">

	<xsl:for-each select=".//xref[not(@role='nodep') and not(@role='runtime')]">
		<xsl:value-of select="@linkend" />
		<xsl:text>&#xA;</xsl:text>
	</xsl:for-each>

</xsl:template>


<!--
####################################################################
# PARA RUNTIME
####################################################################
-->
<xsl:template match="para" mode="runtime">

	<xsl:for-each select=".//xref[not(@role='nodep') and @role='runtime']">
		<xsl:value-of select="@linkend" />
		<xsl:text>&#xA;</xsl:text>
	</xsl:for-each>

</xsl:template>








</xsl:stylesheet>
