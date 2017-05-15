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