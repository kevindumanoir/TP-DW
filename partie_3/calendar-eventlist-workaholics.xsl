<?xml version="1.0"?>

<xsl:stylesheet version  ="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="html"/>

<xsl:template match="/">

  <UL>
    <xsl:apply-templates select="//event[title='Workaholics']"/>
  </UL>
 		
</xsl:template>

<xsl:template match="event">
  <LI>
    Titre : <xsl:value-of select="./title"/>
  </LI>
  
   <LI>
     <xsl:value-of select="concat('le ', substring(./dtstart, 7, 2), '-', substring(./dtstart, 5, 2), '-', substring(./dtstart, 1, 4),
                        ' de ', substring(./dtstart, 10, 2), 'h', substring(./dtstart, 12, 2),
                        ' a ', substring(./dtend, 10, 2), 'h', substring(./dtend, 12, 2))"/>	
  </LI>
  <LI>
    Résumé : <xsl:value-of select="./summary" />
  </LI>
   <LI>
     URL: <xsl:value-of select="./url"/>
  </LI>
    <LI>
     Description : <xsl:value-of select="./description"/>
  </LI>
 
</xsl:template>



</xsl:stylesheet>
