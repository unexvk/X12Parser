<?xml version="1.0"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:msxsl="urn:schemas-microsoft-com:xslt" exclude-result-prefixes="msxsl"
>
    <xsl:output method="xml" indent="yes"/>

    <xsl:template match="@* | node()">
        <xsl:copy>
            <xsl:apply-templates select="@* | node()"/>
        </xsl:copy>
    </xsl:template>

  <xsl:template match="Loop[@LoopId='2010AA' or @LoopId='2010AB' or @LoopId='2310A' or @LoopId='2310B' or @LoopId='2310D']">
    <Provider>
      <xsl:copy-of select="@* | node()"/>
    </Provider>
  </xsl:template>

  <xsl:template match="Loop[@LoopId='2010BA']">
    <Subscriber>
      <xsl:copy-of select="node()"/>
    </Subscriber>
  </xsl:template>

  <xsl:template match="Loop[@LoopId='2010BB' or @LoopId='2010BC']">
    <Payer>
      <xsl:copy-of select="@* | node()"/>
    </Payer>
  </xsl:template>

  <xsl:template match="Loop[@LoopId='2010CA']">
    <Patient>
      <xsl:copy-of select="node()"/>
    </Patient>
  </xsl:template>

  <xsl:template match="Loop[@LoopId='2300']">
    <Claim>
      <xsl:attribute name="Type">
        <xsl:choose>
          <xsl:when test="count(Loop/SV3) > 0">Dental</xsl:when>
          <xsl:when test="count(Loop/SV2) > 0">Institutional</xsl:when>
          <xsl:when test="count(Loop/SV1) > 0">Professional</xsl:when>
        </xsl:choose>
      </xsl:attribute>
      <xsl:attribute name="PatientControlNumber">
        <xsl:value-of select="CLM/CLM01"/>
      </xsl:attribute>
      <xsl:attribute name="TotalCharge">
        <xsl:value-of select="CLM/CLM02"/>
      </xsl:attribute>
      <xsl:apply-templates select="Loop"/>
    </Claim>
  </xsl:template>
  
  <xsl:template match="Loop[@LoopId='2400']">
    <ServiceLine>
      <xsl:attribute name="Number">
        <xsl:value-of select="LX/LX01"/>
      </xsl:attribute>
      <xsl:apply-templates select="*[not(self::LX)]"/>
    </ServiceLine>    
  </xsl:template>

  <xsl:template match="Date[@Qual='472']">
    <DateOfService>
      <xsl:value-of select="."/>
    </DateOfService>
  </xsl:template>

  <xsl:template match="SV1">
    <xsl:attribute name="ChargeAmount">
      <xsl:value-of select="SV102"/>
    </xsl:attribute>
    <xsl:attribute name="Unit">
      <xsl:value-of select="SV103"/>
    </xsl:attribute>
    <xsl:attribute name="Quantity">
      <xsl:value-of select="SV104"/>
    </xsl:attribute>
    <Procedure>
      <xsl:attribute name="Qual">
        <xsl:value-of select="SV101/SV10101"/>
      </xsl:attribute>
      <xsl:attribute name="Code">
        <xsl:value-of select="SV101/SV10102"/>
      </xsl:attribute>
    </Procedure>
  </xsl:template>
  
  <xsl:template match="SV2">
    <xsl:attribute name="RevenueCode">
      <xsl:value-of select="SV201"/>
    </xsl:attribute>
    <xsl:attribute name="ChargeAmount">
      <xsl:value-of select="SV203"/>
    </xsl:attribute>
    <xsl:attribute name="Unit">
      <xsl:value-of select="SV204"/>
    </xsl:attribute>
    <xsl:attribute name="Quantity">
      <xsl:value-of select="SV205"/>
    </xsl:attribute>
    <xsl:if test="string-length(SV207)>0">
      <xsl:attribute name="NonCoveredServiceAmount">
        <xsl:value-of select="SV207"/>
      </xsl:attribute>
    </xsl:if>
    <Procedure>
      <xsl:attribute name="Qual">
        <xsl:value-of select="SV202/SV20201"/>
      </xsl:attribute>
      <xsl:attribute name="Code">
      <xsl:value-of select="SV202/SV20202"/>
      </xsl:attribute>
      <xsl:if test="count(SV202/SV20203) > 0">
        <Modifier>
          <xsl:attribute name="Code">
            <xsl:value-of select="SV202/SV20203"/>
          </xsl:attribute>
        </Modifier>
      </xsl:if>
      <xsl:if test="count(SV202/SV20204) > 0">
        <Modifier>
          <xsl:attribute name="Code">
            <xsl:value-of select="SV202/SV20204"/>
          </xsl:attribute>
        </Modifier>
      </xsl:if>
      <xsl:if test="count(SV202/SV20205) > 0">
        <Modifier>
          <xsl:attribute name="Code">
            <xsl:value-of select="SV202/SV20205"/>
          </xsl:attribute>
        </Modifier>
      </xsl:if>
      <xsl:if test="count(SV202/SV20206) > 0">
        <Modifier>
          <xsl:attribute name="Code">
            <xsl:value-of select="SV202/SV20206"/>
          </xsl:attribute>
        </Modifier>
      </xsl:if>
      <xsl:if test="count(SV202/SV20207) > 0">
        <Description>
            <xsl:value-of select="SV202/SV20207"/>
        </Description>
      </xsl:if>

    </Procedure>
  </xsl:template>
  
</xsl:stylesheet>
