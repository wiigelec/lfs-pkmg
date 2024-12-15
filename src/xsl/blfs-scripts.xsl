<!--
####################################################################
#
# blfs-scripts.xsl
#
####################################################################
-->

<xsl:stylesheet version="1.0"
        xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
        xmlns:exsl="http://exslt.org/common"
        extension-element-prefixes="exsl">


<xsl:output method="text" />

<xsl:param name="files" />
<xsl:param name="scriptsdir" />

<!-- INCLUDES -->
<xsl:include href="script-header.xsl" />
<xsl:include href="script-downloads.xsl" />
<xsl:include href="script-commands.xsl" />


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
                        <xsl:apply-templates select="//sect3[@id]" mode="files" />

                </xsl:when>
                <xsl:otherwise>

			<!-- HEADER -->
        		<xsl:apply-templates select="//sect1[@id = $package]" mode="script-header" />
        		<xsl:apply-templates select="//sect2[@id = $package]" mode="script-header" />
        		<xsl:apply-templates select="//sect3[@id = $package]" mode="script-header" />

        		<!-- DOWNLOADS -->
        		<xsl:apply-templates select="//sect1[@id = $package]" mode="script-download" />
        		<xsl:apply-templates select="//sect2[@id = $package]" mode="script-download"  />

        		<!-- COMMANDS -->
        		<xsl:apply-templates select="//sect1[@id = $package]" mode="script-commands" />
        		<xsl:apply-templates select="//sect2[@id = $package]" mode="script-commands"  />
        		<xsl:apply-templates select="//sect3[@id = $package]" mode="script-commands"  />

			<!-- FOOTER -->
                        <xsl:apply-templates select="//sect1[@id = $package]" mode="script-footer" />
                        <xsl:apply-templates select="//sect2[@id = $package]" mode="script-footer" />
                        <xsl:apply-templates select="//sect3[@id = $package]" mode="script-footer" />

                </xsl:otherwise>
        </xsl:choose>

</xsl:template>


<!--
####################################################################
# SECT1 SECT2 CREATE FILES
####################################################################
-->
<xsl:template match="sect1|sect2|sect3" mode="files">

	<xsl:variable name="create-file" select="concat($scriptsdir,@id,'.build')" />
        <xsl:text>Creating </xsl:text>
        <xsl:value-of select="$create-file" />
        <xsl:text>...</xsl:text>
	<xsl:text>&#xA;</xsl:text>

        <exsl:document href="{$create-file}" method="text">

		<!-- HEADER -->
       		<xsl:apply-templates select="." mode="script-header" />

      		<!-- DOWNLOADS -->
       		<xsl:apply-templates select="." mode="script-download" />

       		<!-- COMMANDS -->
       		<xsl:apply-templates select="." mode="script-commands"  />

		<!-- FOOTER -->
       		<xsl:apply-templates select="." mode="script-footer" />

	</exsl:document>

</xsl:template>



</xsl:stylesheet>
