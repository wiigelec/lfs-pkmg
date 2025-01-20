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
<xsl:param name="book" />

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

			<xsl:choose>
				<!-- LFS BOOK -->
				<xsl:when test="$book='LFS'">
					<xsl:apply-templates select="//chapter[@id='chapter-building-system']/sect1[@role='wrap']" mode="lfs-files" />
				</xsl:when>
				<!-- BLFS BOOK -->
				<xsl:otherwise>
					<xsl:apply-templates select="//sect1[@id]" mode="files" />
                        		<xsl:apply-templates select="//sect2[@id]" mode="files" />
					<xsl:apply-templates select="//sect3[@id]" mode="files" />
				</xsl:otherwise>
			</xsl:choose>

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
# SECT1 SECT2 SECT3 CREATE FILES
####################################################################
-->
<xsl:template match="sect1|sect2|sect3" mode="files">

	<xsl:variable name="create-file" select="concat($scriptsdir,@id,'.build')" />

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

<!--
####################################################################
# SECT1 (LFS) CREATE FILES
####################################################################
-->
<xsl:template match="sect1" mode="lfs-files">

	<xsl:variable name="create-file" select="concat($scriptsdir,./sect1info/productname,'.build')" />

        <exsl:document href="{$create-file}" method="text">

		<!-- HEADER -->
		<xsl:apply-templates select="." mode="lfs-script-header" />

                <!-- DOWNLOADS -->
                <xsl:apply-templates select="." mode="lfs-script-download" />

                <!-- COMMANDS -->
                <xsl:apply-templates select="." mode="script-commands"  />

                <!-- FOOTER -->
                <xsl:apply-templates select="." mode="script-footer" />

	</exsl:document>


</xsl:template>


</xsl:stylesheet>
