<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version='1.0'>

  <xsl:param name="use.extensions">1</xsl:param>
  <xsl:param name="callouts.extension">1</xsl:param>
  <xsl:param name="linenumbering.extension">1</xsl:param>
  <xsl:param name="tablecolumns.extension">1</xsl:param>
  <xsl:param name="textinsert.extension">1</xsl:param>

  <xsl:param name="html.stylesheet">styles.css</xsl:param>
  <xsl:param name="toc.section.depth">2</xsl:param>
  <xsl:param name="annotate.toc">0</xsl:param>

  <xsl:param name="admon.graphics" select="1" />
  <xsl:param name="admon.graphics.extension">.png</xsl:param>
  <xsl:param name="callout.graphics" select="1" />
  <xsl:param name="callout.graphics.extension">.png</xsl:param>

  <xsl:param name="para.propagates.style">1</xsl:param>

  <xsl:template name='user.head.content'>    
    <script type="text/javascript" src="syntax/shCore.js"></script>
    <script type="text/javascript" src="syntax/shBrushJScript.js"></script>
    <script type="text/javascript" src="syntax/shBrushXml.js"></script>
    <script type="text/javascript" src="syntax/shBrushPlain.js"></script>
    <script type="text/javascript" src='script/jquery-1.5.min.js'></script>
    <script type="text/javascript" src='script/tabs.js'></script>
    <link href="syntax/shCore.css" rel="stylesheet" type="text/css" />
    <link href="syntax/shThemeDefault.css" rel="stylesheet" type="text/css" />
  </xsl:template>
  
  <xsl:template name='user.footer.content'>    
    <script type="text/javascript">
       SyntaxHighlighter.all()
    </script>
  </xsl:template>

  <xsl:template match="sect1" mode="toc">
    <xsl:param name="toc-context" select="."/>
    <xsl:call-template name="subtoc">
      <xsl:with-param name="toc-context" select="$toc-context"/>
      <xsl:with-param name="nodes"
        select="sect2|refentry|bridgehead[$bridgehead.in.toc != 0]"/>
    </xsl:call-template>
  </xsl:template>

  <xsl:template match="sect2" mode="toc">
    <xsl:param name="toc-context" select="."/>

    <xsl:call-template name="subtoc">
      <xsl:with-param name="toc-context" select="$toc-context"/>
      <xsl:with-param name="nodes"
        select="sect3|refentry|bridgehead[$bridgehead.in.toc != 0]"/>
    </xsl:call-template>
  </xsl:template>

  <xsl:template match="section[@role='tabbed']">
    <ul class='tabs'>
      <xsl:for-each select="section[@role='tab']">
        <li>
          <xsl:choose>
            <xsl:when test='position() = 1'>
              <xsl:attribute name='class'>active <xsl:value-of select='title'/></xsl:attribute>
            </xsl:when>
            <xsl:otherwise>
              <xsl:attribute name='class'><xsl:value-of select='title'/></xsl:attribute>
            </xsl:otherwise>
          </xsl:choose>
          <a href='javascript:;'>
            <xsl:attribute name='onClick'>changeTab('<xsl:value-of select='title'/>'); return false;</xsl:attribute>
            <xsl:value-of select='title'/>
          </a>
        </li>
      </xsl:for-each>
    </ul>
    <div class='tab-bodies'>
      <xsl:for-each select="section[@role='tab']">
        <div>
          <xsl:attribute name='class'>tab-body <xsl:value-of select='title'/></xsl:attribute>
          <xsl:if test='position() != 1'>
            <xsl:attribute name='style'>display:none</xsl:attribute>
          </xsl:if>
          <xsl:apply-templates/>
        </div>
      </xsl:for-each>
    </div>
  </xsl:template>

  <xsl:template match="httprequest">
    <h4>Request</h4>
    <xsl:apply-templates/>    
    <hr/>
  </xsl:template>

  <xsl:template match="httprequest/header">
    <script type="syntaxhighlighter" class="brush: plain" title="Header">
      <xsl:text disable-output-escaping="yes"><![CDATA[<![CDATA[]]></xsl:text>
      <xsl:apply-templates/>
      <xsl:text disable-output-escaping="yes"><![CDATA[]]]]><![CDATA[>]]></xsl:text></script>
    <noscript><pre class='programlisting'><xsl:apply-templates/></pre></noscript>
  </xsl:template>

  <xsl:template match="httprequest/body">
    <script type="syntaxhighlighter" class="brush: plain" title="Body">
      <xsl:text disable-output-escaping="yes"><![CDATA[<![CDATA[]]></xsl:text>
      <xsl:apply-templates/>
      <xsl:text disable-output-escaping="yes"><![CDATA[]]]]><![CDATA[>]]></xsl:text></script>
    <noscript><pre class='programlisting'><xsl:apply-templates/></pre></noscript>
  </xsl:template>

  <xsl:template match="httpresponse">
    <h4>Response</h4>
    <xsl:apply-templates/>    
  </xsl:template>

  <xsl:template match="httpresponse/header">
    <script type="syntaxhighlighter" class="brush: plain" title="Header">
      <xsl:text disable-output-escaping="yes"><![CDATA[<![CDATA[]]></xsl:text>
      <xsl:apply-templates/>
      <xsl:text disable-output-escaping="yes"><![CDATA[]]]]><![CDATA[>]]></xsl:text></script>
    <noscript><pre class='programlisting'><xsl:apply-templates/></pre></noscript>
  </xsl:template>

  <xsl:template match="httpresponse/body[@format='json']">
    <script type="syntaxhighlighter" class="brush: js" title="Body">
      <xsl:text disable-output-escaping="yes"><![CDATA[<![CDATA[]]></xsl:text>
      <xsl:apply-templates/>
      <xsl:text disable-output-escaping="yes"><![CDATA[]]]]><![CDATA[>]]></xsl:text></script>
    <noscript><pre class='programlisting'><xsl:apply-templates/></pre></noscript>
  </xsl:template>

  <xsl:template match="httpresponse/body[@format='xml']">
    <script type="syntaxhighlighter" class="brush: xml" title="Body">
      <xsl:text disable-output-escaping="yes"><![CDATA[<![CDATA[]]></xsl:text>
      <xsl:apply-templates/>
      <xsl:text disable-output-escaping="yes"><![CDATA[]]]]><![CDATA[>]]></xsl:text></script>
    <noscript><pre class='programlisting'><xsl:apply-templates/></pre></noscript>
  </xsl:template>

</xsl:stylesheet>