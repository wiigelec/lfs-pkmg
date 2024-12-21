<!--
####################################################################
#
# SELECT MENU XSL
#
####################################################################
-->

<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">



<xsl:output method="text" />
<xsl:strip-space elements="*" />


<!--
####################################################################
# ROOT
####################################################################
-->
<xsl:template match="/">

        <xsl:apply-templates select="book/part" />

</xsl:template>


<!--
####################################################################
# PART
####################################################################
-->
<xsl:template match="part">

<xsl:variable name="menu">MENU_<xsl:value-of select="id" /></xsl:variable>

menuconfig <xsl:value-of select="$menu" />
bool "<xsl:value-of select="name" />"
default n

if <xsl:value-of select="$menu" />
<xsl:apply-templates select="chapter" />
endif

</xsl:template>


<!--
####################################################################
# CHAPTER
####################################################################
-->
<xsl:template match="chapter">

<xsl:variable name="menu">MENU_<xsl:value-of select="id" /></xsl:variable>

menuconfig <xsl:value-of select="$menu" />
bool "<xsl:value-of select="name" />"
default n

if <xsl:value-of select="$menu" />
<xsl:apply-templates select="submenu|package" />
endif

</xsl:template>


<!--
####################################################################
# SUBMENU
####################################################################
-->
<xsl:template match="submenu">

<xsl:variable name="menu">MENU_<xsl:value-of select="id" /></xsl:variable>

menuconfig <xsl:value-of select="$menu" />
bool "<xsl:value-of select="name" />"
default n

if <xsl:value-of select="$menu" />
	<xsl:apply-templates select="package" />
endif

</xsl:template>


<!--
####################################################################
# PACKAGES
####################################################################
-->
<xsl:template match="package">

	<!-- CHECK INSTALLED -->
<xsl:variable name="v" select="version/text()" />
<xsl:variable name="iv" select="installed/text()" />

config  CONFIG_<xsl:value-of select="id" />
<xsl:choose>

	<!-- not installed -->
        <xsl:when test="not(installed)">
bool "<xsl:value-of select="id" /><xsl:text> </xsl:text><xsl:value-of select="version" />"
        </xsl:when>

	<!-- current version installed -->
	<xsl:when test="$v=$iv">
bool "*** INSTALLED: <xsl:value-of select="id" /><xsl:text> </xsl:text><xsl:value-of select="version" /> ***"
	</xsl:when>

	<!-- other version installed -->
	<xsl:otherwise>
bool "<xsl:value-of select="concat(id,' ',version)" /> (Installed: <xsl:value-of select="$iv" />)"
	</xsl:otherwise>

</xsl:choose>
default n

</xsl:template>




</xsl:stylesheet>
