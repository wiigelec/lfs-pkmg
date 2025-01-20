<!--
####################################################################
#
#
#
####################################################################
-->

<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">


<xsl:output method="text" />

<xsl:param name="package" />

<!-- extract download -->
<xsl:variable name="extractdownload">
JH_UNPACKDIR=""

case $PACKAGE in
  *.tar.gz|*.tar.bz2|*.tar.xz|*.tgz|*.tar.lzma)
     tar -xvf $SRC_DIR/$PACKAGE &gt; unpacked
     JH_UNPACKDIR=`grep '[^./]\+' unpacked | head -n1 | sed 's@^\./@@;s@/.*@@'`
     ;;

  *.tar.lz)
     bsdtar -xvf $SRC_DIR/$PACKAGE 2&gt; unpacked
     JH_UNPACKDIR=`head -n1 unpacked | cut  -d" " -f2 | sed 's@^\./@@;s@/.*@@'`
     ;;
  *.zip)
     zipinfo -1 $SRC_DIR/$PACKAGE &gt; unpacked
     JH_UNPACKDIR="$(sed 's@/.*@@' unpacked | uniq )"
     if test $(wc -w &lt;&lt;&lt; $JH_UNPACKDIR) -eq 1; then
       unzip $SRC_DIR/$PACKAGE
     else
       JH_UNPACKDIR=${PACKAGE%.zip}
       unzip -d $JH_UNPACKDIR $SRC_DIR/$PACKAGE
     fi
     ;;
esac

### SRC DIR ###
# main file downloaded
if [[ ! -z $JH_UNPACKDIR ]]; then 
	cd $JH_UNPACKDIR
# no main file
else
	# SOURCE DIR
	if [[ -d $SRC_DIR ]]; then

sudo sh -e &lt;&lt; ROOT_EOF
rm -rf $SRC_DIR
ROOT_EOF

	fi

	mkdir -p $SRC_DIR
	cd $SRC_DIR
fi

</xsl:variable>


<xsl:variable name="maindownload">
PACKAGE=${PKG_URL##*/}

# SOURCE DIR
if [[ -d $SRC_DIR ]]; then
sudo sh -e &lt;&lt; ROOT_EOF
rm -rf $SRC_DIR
ROOT_EOF
fi

mkdir -p $SRC_DIR
cd $SRC_DIR

if [[ -f ../$PACKAGE ]]; then mv ../$PACKAGE ./;
	else wget $PKG_URL; fi
</xsl:variable>


<!--
####################################################################
# ROOT
####################################################################
-->
<xsl:template match="/">

	<xsl:apply-templates select="//sect1[@id = $package]" mode="script-download" />
	<xsl:apply-templates select="//sect2[@id = $package]" mode="script-download"  />

</xsl:template>

<!--
####################################################################
# SECT1 SECT2
####################################################################
-->
<xsl:template match="sect1|sect2" mode="script-download" >
####################################################################
# DOWNLOADS
####################################################################

### MAIN DOWNLOAD ###
<xsl:apply-templates select=".//sect2[@role='package']//itemizedlist[1]/listitem/*/ulink[not(@url=' ') and not(@url='')]" mode="main" />
<xsl:apply-templates select=".//sect3[@role='package']//itemizedlist[1]/listitem/*/ulink[not(@url=' ') and not(@url='')]" mode="main" />

### ADDITIONAL DOWNLOADS ###
<xsl:apply-templates select=".//sect2[@role='package']//itemizedlist[position() &gt; 1]/listitem/*/ulink[not(@url=' ')]" mode="additional" />
<xsl:apply-templates select=".//sect3[@role='package']//itemizedlist[position() &gt; 1]/listitem/*/ulink[not(@url=' ')]" mode="additional" />

### FILE EXTRACTION ###
<xsl:value-of select="$extractdownload" />

</xsl:template>


<!--
####################################################################
# ULINK
####################################################################
-->
<!-- main download -->
<xsl:template match="ulink" mode="main">
PKG_URL=<xsl:value-of select="@url" />

<xsl:value-of select="$maindownload" />

</xsl:template>

<!-- additional downloads -->
<xsl:template match="ulink" mode="additional">

        <xsl:text>wget </xsl:text>
        <xsl:value-of select="@url" />
        <xsl:text>&#xA;</xsl:text>

</xsl:template>

<!--
####################################################################
# sect1 (LFS)
####################################################################
-->
<xsl:template match="sect1" mode="lfs-script-download" >
####################################################################
# DOWNLOADS
####################################################################

### MAIN DOWNLOAD ###

PKG_URL=<xsl:value-of select="./sect1info/address" />

<xsl:value-of select="$maindownload" />

</xsl:template>



</xsl:stylesheet>
