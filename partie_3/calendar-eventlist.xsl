<?xml version="1.0"?>

<xsl:stylesheet version  ="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="html"/>

<xsl:template match="/">
    <table class="table table-responsive">
      <tr>
        <th>Titre</th>
        <th>Date</th>
        <th>Résumé</th>
        <th>URL</th>
        <th>Description</th>
        <th>Année</th>
        <th>Âge requis</th>
        <th>Date de première diffusion</th>
        <th>Durée</th>
        <th>Genre</th>
        <th>Langue</th>
        <th>Pays</th>
        <th>Score IMDB</th>
        <th>Nombre de votes IMDB</th>
        <th>Images</th>
      </tr>
      <xsl:apply-templates select="//event">
        <xsl:sort select="./title" />
      </xsl:apply-templates>
    </table>
</xsl:template>

<xsl:template match="event">
<tr id="event-{@uid}">
  <td>
    <xsl:value-of select="./title"/>
  </td>
  
   <td>
     <xsl:value-of select="concat('le ', substring(./dtstart, 7, 2), '-', substring(./dtstart, 5, 2), '-', substring(./dtstart, 1, 4),
                        ' de ', substring(./dtstart, 10, 2), 'h', substring(./dtstart, 12, 2),
                        ' a ', substring(./dtend, 10, 2), 'h', substring(./dtend, 12, 2))"/>	
  </td>
  <td>
    <xsl:value-of select="./summary" />
  </td>
   <td>
     <xsl:value-of select="./url"/>
  </td>
  <td>
     <xsl:value-of select="./description"/>
  </td>
</tr>
 
</xsl:template>



</xsl:stylesheet>
