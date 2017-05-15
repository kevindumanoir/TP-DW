# TP Données du Web : Préambule

Ce TP a été réalisé par **Axel CÉARD** et **Kévin DUMANOIR**, B3442, 3IF INSA Lyon 2016-2017.

Voilà les fichiers concernés par chaque partie :
* Partie I : countries_TP.xml
* Partie II : countries_TP.xml, pays_du_monde_tableau_3IF.xsl, countries_TP.html
* Partie III : path : partie_3, fichiers : PartieAjaxDOM.html, calendar-short.xml, calendar-eventlist-workaholics.xsl, calendar-eventlist.xsl

# Partie I : XML, DTD, XPath, XSLT

## 1. Exploration de l'instance

Pour la question 1, il s'agit de donner les expressions XPath, et quelques résultats, permettant de sélectionner les éléments demandés.

### Q1.1 : Tous les pays

>/countries/country

```xml
<country>
        <name>
            <common>Aruba</common>
            <official>Aruba</official>
            <native_name lang="nld">
                <official>Aruba</official>
                <common>Aruba</common>
            </native_name>
            <native_name lang="pap">
                <official>Aruba</official>
                <common>Aruba</common>
            </native_name>
        </name>
        <tld>.aw</tld>
        <cca2>AW</cca2>
        <ccn3>533</ccn3>
        <cca3>ABW</cca3>
        <cioc>ARU</cioc>
        <currency>AWG</currency>
        <callingCode>297</callingCode>
        <capital>Oranjestad</capital>
        <altSpellings>AW</altSpellings>
        <region>Americas</region>
        <subregion>Caribbean</subregion>
        <languages>
            <nld>Dutch</nld>
            <pap>Papiamento</pap>
        </languages>
        <latlng>12.5</latlng>
        <latlng>-69.96666666</latlng>
        <demonym>Aruban</demonym>
        <landlocked>false</landlocked>
        <area>180</area>
    </country>
```

### Q1.2 : Les noms officiels des pays

> //name/official/text()

__Note:__ Pour récupérer le node, enlever /text()

```
    Aruba
    Islamic Republic of Afghanistan
    Republic of Angola
    Anguilla
    Åland Islands
```

### Q1.3 : Éléments ayant au moins un attribut

> //\*[@\*]

```xml
<native_name lang="nld">
    <official>Aruba</official>
    <common>Aruba</common>
</native_name>
<native_name lang="pap">
    <official>Aruba</official>
    <common>Aruba</common>
</native_name>
<native_name lang="prs">
    <official>جمهوری اسلامی افغانستان</official>
    <common>افغانستان</common>
</native_name>
 <native_name lang="pus">
    <official>د افغانستان اسلامي جمهوریت</official>
    <common>افغانستان</common>
</native_name>
<native_name lang="tuk">
    <official>Owganystan Yslam Respublikasy</official>
    <common>Owganystan</common>
</native_name>
```

### Q1.4 : Les noms officiels des pays en français pour ceux qui en ont

> //country/name/native_name[@lang="fra"]/official/text()

```
Territoire des Terres australes et antarctiques françaises
République du Burundi
Royaume de Belgique
République du Bénin
République du Burkina
```

### Q1.5 : Le deuxième nom natif officiel des pays

> //country/name/native_name[position()=2]/official/text()

```
Aruba
República Argentina
Sāmoa Amelika
Republika y'Uburundi 
Royaume de Belgique
```

### Q1.6 : Les noms communs des pays qui n'ont pas de nom natif

> //country/name[count(native_name)=0]/common/text()

```
Antarctica
```

### Q1.7 : Les noms officiels des pays ayant plus (strict) de 9 voisins (borders)

> //country[count(borders)>9]/name/official/text()

```
Federative Republic of Brazil
People's Republic of China
Russian Federation
```

### Q1.8 : Les noms officiels des pays dont la capitale commence par "Pa"

> //country[substring(capital,1, 2)="Pa"]/name/official/text()

**Un équivalent intéressant est le suivant :**

> //country[starts-with(capital, "Pa")]/name/official/text()

```
American Samoa
French Republic
Federated States of Micronesia
Republic of Panama
```

### Q1.9 : Les sous-continents (subregion) sans doublons

> //subregion[not(. = ../following-sibling::country/subregion )]

**:warning: ATTENTION:** On peut également utiliser `preceding-sibling` mais cela **change l'ordre du result set fourni par XPath**.

**Petite explication pour nos révisions de DS:** dans ce critère, on sélectionne les subregions (.) qui ne sont pas égales à une autre subregion suivante (../following-sibling::country/subregion)

```
[vide]
Western Europe
Australia and New Zealand
Southern Asia
Micronesia
```

## 2. Mise à jour de l'instance [XML, DTD]

L'élément concerné est le noeud `languages`, fichier DTD modifié à la ligne **9**

Pour m'assurer que le document est valide, nous avons utilisé les fonctions de vérification de Editix (via `CTRL+K`)

## 3. Mise en forme du corpus des pays du monde [XSLT]

Veuillez consulter le fichier `countries_TP.xml` fourni dans ce dossier. La génération HTML de ce fichier est également disponible sous le nom `countries_TP.html`. `resultatTP_attendu.html` représente le résultat fourni et demandé par le TP.

# Partie II: XQuery

### Q1 : Retournez les noms officiels des pays en ordre alphabétique.

```xquery
<nom_pays>{
  for $c in //country/name/official
      order by $c
      return <nom>{data($c)}</nom>
  }
</nom_pays>
```

```xml
<nom_pays>
  <nom>American Samoa</nom>
  <nom>Anguilla</nom>
  <nom>Antarctica</nom>
  <nom>Antigua and Barbuda</nom>
  <nom>Arab Republic of Egypt</nom>
  <nom>Argentine Republic</nom>
  <nom>Aruba</nom>
  <nom>Bailiwick of Guernsey</nom>
  <nom>Bailiwick of Jersey</nom>
  ...
</nom_pays>
```

### Q2 : Retournez les noms des pays en français

_NB: Nous avons décidé de prendre les noms officiels en français, l'énoncé nous laissant le libre choix. Les noms sont également triés par ordre alphabétique._

```xquery
<nom_pays>{
  for $c in //country/name/native_name[@lang="fra"]/official
    order by $c
      return <nom>{data($c)}</nom>
  }
</nom_pays>
```

```xml
<nom_pays>
  <nom>Bailliage de Guernesey</nom>
  <nom>Bailliage de Jersey</nom>
  <nom>Canada</nom>
  <nom>Collectivité de Saint-Barthélemy</nom>
  <nom>Collectivité territoriale de Saint-Pierre-et-Miquelon</nom>
  <nom>Confédération suisse</nom>
  <nom>Département de Mayotte</nom>
  <nom>Grand-Duché de Luxembourg</nom>
  <nom>Guadeloupe</nom>
  <nom>Guyanes</nom>
  ...
</nom_pays>  
```

### Q3 : Retournez les républiques

_NB : Les noms sont triés par ordre alphabétique._

```xquery
<nom_pays>{
  for $c in //country/name/official[contains(lower-case(text()), "republic")]
    order by $c
      return <nom>{data($c)}</nom>
  }
</nom_pays>
```

_NB: Afin de ne pas avoir de problèmes avec la casse, on convertit le nom du pays entièrement en minuscule pour le comparer avec "republic"_

```xml
<nom_pays>
  <nom>Arab Republic of Egypt</nom>
  <nom>Argentine Republic</nom>
  <nom>Bolivarian Republic of Venezuela</nom>
  <nom>Central African Republic</nom>
  <nom>Co-operative Republic of Guyana</nom>
  <nom>Czech Republic</nom>
  <nom>Democratic People's Republic of Korea</nom>
  <nom>Democratic Republic of São Tomé and Príncipe</nom>
  <nom>Democratic Republic of Timor-Leste</nom>
  <nom>Democratic Republic of the Congo</nom>
  <nom>Democratic Socialist Republic of Sri Lanka</nom>
  <nom>Dominican Republic</nom>
  ...
</nom_pays>
```

### Q4 : Affichez les appelations alternatives (altSpellings) des pays qui ne se trouvent pas parmi les noms de ce pays (officiels ou natifs).

```xquery
<nom_pays>{
  for $c in //country
    for $d in $c/altSpellings
    where $d != $c/name/native_name/official and $d != $c/name/official
    return  <pays nom="{$c/name/official}">
    <nomAlternatif_different_des_noms>{data($d)}</nomAlternatif_different_des_noms>
    </pays>
  }
</nom_pays>
```

```xml
<nom_pays>
  <pays nom="Aruba">
    <nomAlternatif_different_des_noms>AW</nomAlternatif_different_des_noms>
  </pays>
  <pays nom="Islamic Republic of Afghanistan">
    <nomAlternatif_different_des_noms>AF</nomAlternatif_different_des_noms>
  </pays>
  <pays nom="Islamic Republic of Afghanistan">
    <nomAlternatif_different_des_noms>Afġānistān</nomAlternatif_different_des_noms>
  </pays>
  <pays nom="Republic of Angola">
    <nomAlternatif_different_des_noms>AO</nomAlternatif_different_des_noms>
  </pays>
  <pays nom="Republic of Angola">
    <nomAlternatif_different_des_noms>ʁɛpublika de an'ɡɔla</nomAlternatif_different_des_noms>
  </pays>
  <pays nom="Anguilla">
    <nomAlternatif_different_des_noms>AI</nomAlternatif_different_des_noms>
  </pays>
  ...
</nom_pays>
```

### Q5 : Pour chaque continent : donnez le nombre de pays, le pays avec le plus grande superficie ainsi que les langues parlés sur ce continent sans doublons.

```xquery
<infosContinents>{
  for $c in distinct-values(//country/region)
      let $countries := //country[region = $c]
      let $plusGrandPays := //country[area = max($countries/area)]
      return <continent nom="{$c}" nbPays="{count($countries)}">
      <infos>
        <plusGrandPays superficie="{number($plusGrandPays/area)}">{data($plusGrandPays/name/official)}</plusGrandPays>
        <languesParles>{
          for $d in distinct-values($countries/languages/*)
          return data($d) 
        }</languesParles>
      </infos>
      </continent>
  }
</infosContinents>
```

_Note: si on avait utilisé `let $countries := //country[region/text() = $c]`, les données pour les pays sans continents auraient été erronées._

```xml
<infosContinents>
  <continent nom="Americas" nbPays="56">
    <infos>
      <plusGrandPays superficie="9.98467E6">Canada</plusGrandPays>
      <languesParles>Dutch Papiamento English Guaraní Spanish French Belizean Creole Aymara Quechua Portuguese Greenlandic Haitian Creole Jamaican Patois</languesParles>
    </infos>
  </continent>
  <continent nom="Asia" nbPays="50">
    <infos>
      <plusGrandPays superficie="9.706961E6">People's Republic of China</plusGrandPays>
      <languesParles>Dari Pashto Turkmen Arabic Armenian Russian Azerbaijani Bengali Malay Dzongkha Chinese Georgian English Indonesian Hindi Tamil Persian Aramaic Sorani Hebrew Japanese Kazakh Kyrgyz Khmer Korean Lao French Sinhala Portuguese Maldivian Burmese Mongolian Nepali Urdu Filipino Thai Tajik Tetum Turkish Uzbek Vietnamese</languesParles>
    </infos>
  </continent>
  <continent nom="Africa" nbPays="58">
    <infos>
      <plusGrandPays superficie="2.381741E6">People's Democratic Republic of Algeria</plusGrandPays>
      <languesParles>Portuguese French Kirundi English Tswana Sango Kikongo Lingala Tshiluba Swahili Arabic Comorian Tigrinya Berber Hassaniya Spanish Amharic Sotho Malagasy Mauritian Creole Chewa Afrikaans German Herero Khoekhoe Kwangali Lozi Ndonga Kinyarwanda Somali Swazi Seychellois Creole Southern Ndebele Northern Sotho Southern Sotho Tsonga Venda Xhosa Zulu Chibarwe Kalanga Khoisan Ndau Northern Ndebele Shona Tonga Zimbabwean Sign Language</languesParles>
    </infos>
  </continent>
  <continent nom="Europe" nbPays="53">
    <infos>
      <plusGrandPays superficie="1.7098242E7">Russian Federation</plusGrandPays>
      <languesParles>Swedish Albanian Catalan Austro-Bavarian German German French Dutch Bulgarian Bosnian Croatian Serbian Belarusian Russian Swiss German Italian Romansh Greek Turkish Czech Slovak Danish Basque Galician Occitan Spanish Estonian Finnish Faroese English Guernésiais Hungarian Manx Irish Icelandic Sardinian Jèrriais Lithuanian Luxembourgish Latvian Moldavian Macedonian Maltese Montenegrin Norwegian Nynorsk Norwegian Bokmål Sami Polish Portuguese Romanian Norwegian Slovene Ukrainian Latin</languesParles>
    </infos>
  </continent>
  <continent nom="Oceania" nbPays="27">
    <infos>
      <plusGrandPays superficie="7.692024E6">Commonwealth of Australia</plusGrandPays>
      <languesParles>English Samoan Cook Islands Māori Fijian Fiji Hindi Chamorro Spanish Gilbertese Marshallese Carolinian French Norfuk Niuean Nauru Māori New Zealand Sign Language Palauan Hiri Motu Tok Pisin Tokelauan Tongan Tuvaluan Bislama</languesParles>
    </infos>
  </continent>
  <continent nom="" nbPays="4">
    <infos>
      <plusGrandPays superficie="1.4E7">Antarctica</plusGrandPays>
      <languesParles>French Norwegian English</languesParles>
    </infos>
  </continent>
</infosContinents>
```

### Q6 : Comptez le nombre de langues pour chaque pays à l'aide d'une fonction appelée : local:compteLangues, prenant en paramètre un noeud country et retournant le nombre de langues parlées.

```xquery
declare function local:compteLangues($country as node())
as xs:decimal?
{
  let $nbLangues := count($country/languages/*)
  return ($nbLangues)
};

<nblangues>{
for $c in //country
  return element {lower-case($c/cca3)} {
    <nom>{data($c/name/official)}</nom>,
    <nblangues>{local:compteLangues($c)}</nblangues>
  }
}
</nblangues>
```

_Il existe une version alternative, suffisamment intéressante à notre avis pour fournir le code dans ce compte-rendu. Le voici :_

```xquery
declare function local:compteLangues($country as node())
as xs:decimal?
{
  let $nbLangues := count($country/languages/*)
  return ($nbLangues)
};

<nblangues>{
for $c in //country
  return element {lower-case($c/cca3)} {
    element nom {data($c/name/official)},
    element nblangues {local:compteLangues($c)}
  }
}
</nblangues>
```

**Dans un noeud généré avec `element`, il est nécessaire de séparer chaque noeud enfant par des virgules, MÊME s'ils sont de la forme `<noeud></noeud>`.**

```xml
<nblangues>
  <abw>
    <nom>Aruba</nom>
    <nblangues>2</nblangues>
  </abw>
  <afg>
    <nom>Islamic Republic of Afghanistan</nom>
    <nblangues>3</nblangues>
  </afg>
  <ago>
    <nom>Republic of Angola</nom>
    <nblangues>1</nblangues>
  </ago>
  <aia>
    <nom>Anguilla</nom>
    <nblangues>1</nblangues>
  </aia>
  <ala>
    <nom>Åland Islands</nom>
    <nblangues>1</nblangues>
  </ala>
  <alb>
    <nom>Republic of Albania</nom>
    <nblangues>1</nblangues>
  </alb>
  <and>
    <nom>Principality of Andorra</nom>
    <nblangues>1</nblangues>
  </and>
  ...
</nblangues>
```

# Partie III : Ajax & DOM

Cette partie a été réalisée dans le document `PartieAjaxDOM.html`.

Comme bonus, nous avons amélioré la mise en page des événements sous forme d'un tableau (bouton 4 uniquement) et via l'utilisation de Bootstrap.
