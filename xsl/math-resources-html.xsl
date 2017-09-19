<?xml version='1.0'?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

<xsl:import href="../../mathbook/xsl/mathbook-html.xsl" />

<xsl:param name="html.css.file" select="'mathbook-1.css'" />
<xsl:param name="html.knowl.webwork.inline" select="'no'" />
<xsl:param name="html.knowl.exercise.inline" select="'no'" />

<xsl:template match="desmos">
  <xsl:variable name="url">
    <xsl:text>https://www.desmos.com/calculator/</xsl:text>
    <xsl:value-of select="@desmos"/>
  </xsl:variable>
  <p>
  <xsl:text>Click </xsl:text>
  <xsl:element name="a">
    <xsl:attribute name="href">
      <xsl:value-of select="$url" />
    </xsl:attribute>
    <xsl:attribute name="target">
      <xsl:text>blank</xsl:text>
    </xsl:attribute>
    <xsl:text>here</xsl:text>
  </xsl:element>
  <xsl:text> to open the Desmos graph full screen.</xsl:text>
  </p>
  <xsl:element name="iframe">
    <xsl:attribute name="src">
      <xsl:value-of select="$url" />
    </xsl:attribute>
    <xsl:attribute name="width">
      <xsl:text>100%</xsl:text>
    </xsl:attribute>
    <xsl:attribute name="height">
      <xsl:text>500px</xsl:text>
    </xsl:attribute>
    <xsl:attribute name="style">
      <xsl:text>border: 1px solid #ccc</xsl:text>
    </xsl:attribute>
    <xsl:attribute name="frameborder">
      <xsl:text>0</xsl:text>
    </xsl:attribute>
  </xsl:element>
</xsl:template>

</xsl:stylesheet>
