<!--
####################################################################
#
# SCRIPT HEADER XSL
#
####################################################################
-->

<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:output method="text" />

<xsl:param name="package" />
<xsl:param name="version" />
<xsl:param name="pkglist" />


<xsl:variable name="header">
# ENV
if [ -r /etc/profile ]; then source /etc/profile; fi
export MAKEFLAGS="-j$(nproc)"

unset CFLAGS
unset CXXFLAGS
unset LDFLAGS
unset NINJAJOBS
unset MAKELEVEL
unset MAKE_TERMOUT
unset MAKE_TERMERR

set -e

# CONFIG VARS
SOURCE_DIR=/sources
SRC_DIR=$SOURCE_DIR/$PKG_ID

# DIFF LOGS
TIMESTAMP=/tmp/timestamp$RANDOM
[ ! -d $LPM_DIFFLOG ] &amp;&amp; sudo mkdir -p $LPM_DIFFLOG
difflog1=$LPM_DIFFLOG/${PKG_ID}--${PKG_VERS}.difflog1
difflog2=$LPM_DIFFLOG/${PKG_ID}--${PKG_VERS}.difflog2
</xsl:variable>

<xsl:variable name="footer">
### CLEANUP ###
cd $SOURCE_DIR
sudo sh -e &lt;&lt; ROOT_EOF
rm -rf $SRC_DIR
ROOT_EOF


exit
</xsl:variable>


<!--
####################################################################
# ROOT
####################################################################
-->
<xsl:template match="/">

	<xsl:apply-templates select="//sect1[@id = $package]" mode="script-header" />
        <xsl:apply-templates select="//sect2[@id = $package]" mode="script-header" />
        <xsl:apply-templates select="//sect3[@id = $package]" mode="script-header" />

</xsl:template>


<!--
####################################################################
# SECT1 SECT2 SECT3 HEADER
####################################################################
-->
<xsl:template match="sect1|sect2|sect3" mode="script-header">#!/bin/bash
####################################################################
#
#  <xsl:value-of select="@id" />
#
####################################################################

set -e

# PACKAGE INFO
PKG_ID=<xsl:value-of select="@id" />
<xsl:variable name="match" select="@id" />
PKG_VERS=<xsl:value-of select="document($pkglist)//package[id=$match]/version" />

<xsl:value-of select="$header" />

</xsl:template>


<!--
####################################################################
# sect1 (LFS) HEADER
####################################################################
-->
<xsl:template match="sect1" mode="lfs-script-header">#!/bin/bash
####################################################################
#
#  <xsl:value-of select="./sect1info/productname" />
#
####################################################################

set -e

# PACKAGE INFO
PKG_ID=<xsl:value-of select="./sect1info/productname" />
<xsl:variable name="match" select="./sect1info/productname" />
PKG_VERS=<xsl:value-of select="document($pkglist)//package[id=$match]/version" />

<xsl:value-of select="$header" />

</xsl:template>


<!--
####################################################################
# SECT1 SECT2 SECT3 FOOTER
####################################################################
-->
<xsl:template match="sect1|sect2|sect3" mode="script-footer">

<xsl:value-of select="$footer" />

</xsl:template>





</xsl:stylesheet>
