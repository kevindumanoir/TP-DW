<?xml version="1.0" encoding="UTF-8"?>

<!-- New document created with EditiX at Tue Mar 14 15:36:01 CET 2017 -->

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<xsl:output method="html"/>
	
	<xsl:template match="/"> 
	<html> 
		<head> 
		    <title> 
		    Pays du monde 
		  </title> 
		 </head> 
		 
		 <body style="background-color:white;">
		   	  <h1>Les pays du monde</h1> 
		      <h2>Mise en forme par :</h2>
		      <ul>
		      	<li>Axel CÉARD <b>(B3442)</b></li>
		      	<li>Kévin DUMANOIR <b>(B3442)</b></li> 
		      </ul>
		      
		      <xsl:apply-templates select="countries/metadonnees" />

		      <!-- VALABLE DANS CE DOC UNIQUEMENT (jusqu'à preuve du contraire): Utiliser preceding au lieu de preceding met les pays sans continents à la fin -->
		      <xsl:variable name="regions" select='//region[not(. = ../preceding-sibling::country/region )]'/>

		      <p>
		      	  Continents (regions) : 
			      <xsl:for-each select='$regions'>
			      	<xsl:if test='string-length() = 0'>
			      		Sans continent
			      	</xsl:if>	
			      	<xsl:value-of select="." /> (<xsl:value-of select='count(//country[region=current()])' /> pays)<xsl:if test="position() != last()">, </xsl:if>
			      </xsl:for-each>
		  		</p>

		  		<!-- NON FONCTIONNEL : <xsl:variable name="maxBorders" select='//country[not(count(../country/borders) &gt; count(borders))]'/>
		  		<p>
		  			Le pays ayant le plus de voisins frontaliers est : <xsl:value-of select='$maxBorders/name/common' /> (<xsl:value-of select='count($maxBorders/borders)' />)
		  		</p> -->

				<p>
		  			Le pays ayant le plus de voisins frontaliers est : 
			  		<xsl:for-each select="//country">
			  			<!-- Si data-type n'est pas défini, il considère la valeur renvoyée par le select comme du texte, et donc fais un tri alphabétique. -->
			  			<xsl:sort select="count(borders)" data-type="number" order='descending' />
			  			<xsl:if test='position() = 1'>
							<xsl:value-of select='name/common' /> (<xsl:value-of select='count(borders)' />)
			  			</xsl:if>
			  		</xsl:for-each>
		  		</p>	

		      <xsl:apply-templates select="$regions" />
		 </body> 
	</html> 
	</xsl:template> 
	
	<xsl:template match="metadonnees">
	 <p style="text-align:center; color:blue;">
		Objectif : <xsl:value-of select="objectif"/>
	 </p><hr/>
	</xsl:template>

	<xsl:template match="country">
		<tr>
			<td>
				<xsl:value-of select="position()" />
			</td>
			<td>
				<span style="color: green"><xsl:value-of select="name/common" /></span> (<xsl:value-of select="name/official" />)
				<xsl:if test='count(name/native_name[@lang="fra"]) = 1'>
				<br />
				<span style="color:brown">Nom français : <xsl:value-of select='name/native_name[@lang="fra"]/official' /></span>
				</xsl:if>
			</td>
			<td>
				<xsl:value-of select="capital" />
			</td>
			<td>
				<xsl:for-each select="borders">
					<!-- Pour récupérer l'élément actuel dans un for-each: current() ! -->
					<xsl:value-of select="//country[cca3=current()]/name/common" />
					<xsl:if test="position() != last()">, </xsl:if>
				</xsl:for-each>
			</td>
			<td>
				<xsl:apply-templates select="latlng" />
			</td>
			<td>
				<!-- Pour utiliser un élément dans un attribut, il faut passer la requête XPath entre {} -->
				<img src='http://www.geonames.org/flags/x/{translate(cca2, "ABCDEFGHIJKLMNOPQRSTUVWXYZ", "abcdefghijklmnopqrstuvwxyz")}.gif' height="40" width="60" />
			</td>
		</tr>
	</xsl:template>

	<xsl:template match="latlng">
		<xsl:if test="position() = last()">
			Longitude:  <xsl:value-of select="."/>
		</xsl:if>
		<xsl:if test="position() != last()">
			Latitude:  <xsl:value-of select="."/><br />
		</xsl:if>
	</xsl:template>

	<xsl:template match="region">
		<h3>Pays du continent : <xsl:value-of select="." /> par sous-régions :</h3>
		<xsl:apply-templates select="//country[region=current()]/subregion[not(. = ../preceding-sibling::country/subregion )]" />
		<hr />
	</xsl:template>

	<xsl:template match="subregion">
		<h4><xsl:value-of select="." /></h4>
		<table border="3" width="100%" align="center">
		    <tr>
		    	<th>
		    		N°
		    	</th>
		    	<th>
		    		Nom
		    	</th>
		    	<th>
		    		Capitale
		    	</th>
		    	<th>
		    		Voisins
		    	</th>
		    	<th>
		    		Coordonnées
		    	</th>
		    	<th>
		    		Drapeau
		    	</th>
		    </tr>
		    <xsl:apply-templates select="//country[subregion=current()]" />
		</table>
	</xsl:template>

</xsl:stylesheet>


