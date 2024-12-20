<!--
####################################################################
#
#
#
####################################################################
-->

<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:output method="xml" />


<!-- IGNORE PART -->
<!-- use %% for exact match %% -->
<xsl:variable name="part-ignore">
	%introduction%
</xsl:variable>

<!-- IGNORE PACKAGE -->
<xsl:variable name="package-ignore">
	%postlfs-config-bootdisk%
	%postlfs-console-fonts%
	%postlfs-firmware%
	%postlfs-devices%
	%postlfs-config-skel%
	%postlfs-users-groups%
	%postlfs-config-logon%
	%vulnerabilities%
	%fw-firewall%
	%aboutlvm%
	%raid%
	%grub-setup%
	%perl-alternatives%
	%gitserver%
	%svnserver%
	%advanced-network%
	%wireless-kernel%
	%basicnet-mailnews-other%
	%upgradedb%
	%tuning-fontconfig%
	%TTF-and-OTF-fonts%
	%kde-intro%
	%kde-add-pkgs%
	%alsa%
	%xorg-config%
	%lxqt-pre-install%
</xsl:variable>

<!-- SECT2 PACKAGE -->
<xsl:variable name="sect2-pkg">
	%java-bin%
</xsl:variable>

<!-- ### VERSIONS ### -->
<xsl:param name="book-version" />
<xsl:param name="kf6-version" />

<!-- BASE VERSION -->
<xsl:variable name="base-version" select="concat('0.',$book-version)" />
<xsl:variable name="bv-pkg">
	%xorg-env%
	%ojdk-conf%
	%postlfs-config-profile%
	%postlfs-config-vimrc%
	%initramfs%
	%tex-path%
</xsl:variable>

<!-- XORG VERSION -->
<xsl:variable name="xorg-version" select="concat('7.',$book-version)" />
<xsl:variable name="xorg-pkg">
	%xorg7-lib%
	%xorg7-app%
	%xorg7-font%
	%xorg7-legacy%
</xsl:variable>

<!-- KF6 VERSION -->
<xsl:variable name="kf6-pkg">
	%kf6-intro%
</xsl:variable>


<!-- SUBMENU -->
<xsl:variable name="submenu">
        %perl-modules%
        %python-modules%
        %perl-deps%
        %python-dependencies%
	%xorg7%
        %xorg7-input-driver%
</xsl:variable>


<!--
####################################################################
#
####################################################################
-->
<xsl:template match="/">
	<book>
		<xsl:apply-templates select="//part" />
	</book>
</xsl:template>


<!--
####################################################################
# PART
####################################################################
-->
<xsl:template match="part">

	<!-- skip ignore list -->
        <xsl:variable name="id-ignore" select="concat('%',@id,'%')" />
        <xsl:if test="not(contains($part-ignore,$id-ignore))">
	
	<xsl:text>&#xA;</xsl:text>
	<part>
		<id><xsl:value-of select="@id" /></id>
		<name><xsl:value-of select="@xreflabel" /></name>
		<xsl:apply-templates select="chapter" />
	</part>

	</xsl:if>

</xsl:template>

<!--
####################################################################
# CHAPTER
####################################################################
-->
<xsl:template match="chapter">

	<xsl:text>&#xA;</xsl:text>
	<chapter>
		<id><xsl:value-of select="@id" /></id>
		<name><xsl:value-of select="title" /></name>
		<xsl:apply-templates select="sect1[@id]" />
		<xsl:apply-templates select="sect2[@id]" />
	</chapter>

</xsl:template>


<!--
####################################################################
# SECT1
####################################################################
$$ VERSION $$ for later string correction in bash
-->
<xsl:template match="sect1" >

	<!-- skip ignore list -->
        <xsl:variable name="id-test" select="concat('%',@id,'%')" />
        <xsl:if test="not(contains($package-ignore,$id-test))">
		
		<!-- submenu -->
		<xsl:choose>
			<xsl:when test="contains($submenu,$id-test)">
				<xsl:text>&#xA;</xsl:text>
				<xsl:text>&#xA;</xsl:text>
				<submenu>
					<id><xsl:value-of select="@id" /></id>
					<name><xsl:value-of select="title" /></name>
					<xsl:apply-templates select="sect2[@id]" />
				</submenu>
			</xsl:when>


			<!-- sect2 package -->
        		<xsl:when test="contains($sect2-pkg,$id-test)">
				<xsl:apply-templates select="sect2[@id]" />
			</xsl:when>

			<!-- sect1 package -->
			<xsl:otherwise>	
				<xsl:text>&#xA;</xsl:text>
				<package>
					<id><xsl:value-of select="@id" /></id>
					<!-- SPECIAL VERSIONS -->
					<xsl:choose>
						<xsl:when test="contains($bv-pkg,$id-test)">
							<version>$$version-<xsl:value-of select="$base-version" />$$</version>
						</xsl:when>
						<xsl:when test="contains($xorg-pkg,$id-test)">
							<version>$$version-<xsl:value-of select="$xorg-version" />$$</version>
						</xsl:when>
						<xsl:when test="contains($kf6-pkg,$id-test)">
							<version>$$version-<xsl:value-of select="$kf6-version" />$$</version>
						</xsl:when>
						<xsl:otherwise>
							<version>$$<xsl:value-of select="@xreflabel" />$$</version>
						</xsl:otherwise>
					</xsl:choose>
				</package>
			</xsl:otherwise>
		</xsl:choose>

	</xsl:if>

</xsl:template>

<!--
####################################################################
# SECT2
####################################################################
$$ VERSION $$ for later string correction in bash
-->
<xsl:template match="sect2" >

	<!-- skip ignore list -->
        <xsl:variable name="id-test" select="concat('%',@id,'%')" />
        <xsl:if test="not(contains($package-ignore,$id-test))">

	<xsl:text>&#xA;</xsl:text>
        <package>
                <id><xsl:value-of select="@id" /></id>
		<!-- SPECIAL VERSIONS -->
                <xsl:choose>
			<xsl:when test="contains($bv-pkg,$id-test)">
				<version>$$version-<xsl:value-of select="$base-version" />$$</version>
			</xsl:when>
			<xsl:when test="contains($xorg-pkg,$id-test)">
				<version>$$version-<xsl:value-of select="$xorg-version" />$$</version>
			</xsl:when>
			<xsl:when test="contains($kf6-pkg,$id-test)">
				<version>$$version-<xsl:value-of select="$kf6-version" />$$</version>
			</xsl:when>
			<xsl:otherwise>
				<version>$$<xsl:value-of select="@xreflabel" />$$</version>
			</xsl:otherwise>
		</xsl:choose>
	</package>

	</xsl:if>

</xsl:template>



</xsl:stylesheet>
