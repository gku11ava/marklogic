xquery version "1.0-ml";

module namespace plugin = "http://marklogic.com/data-hub/plugins";

declare namespace es = "http://marklogic.com/entity-services";

import module namespace hR = "http://com.marklogic.es.uml.hr#HR-0.0.1" 
      at "/ext/entity-services/HR-0.0.1.xqy";

declare option xdmp:mapping "false";

(:~
 : Create Content Plugin
 :
 : @param $id          - the identifier returned by the collector
 : @param $options     - a map containing options. Options are sent from Java
 :
 : @return - your transformed content
 :)
declare function plugin:create-content(
  $id as xs:string,
  $options as map:map) as node()?
{
  let $doc := fn:doc($id)
  let $content := hR:instance-to-canonical(hR:extract-instance-Department($doc/es:envelope/es:instance, $options), "xml")
 
(: Generated Code of Type calculateds For Class Department :)
let $deptIRI:= concat("http://www.w3.org/ns/org#d",string($content//departmentId))
let $_ := map:put($options, "deptIRI", $deptIRI)
let $uri:= concat("/department/",string($content//departmentId),".xml")
let $_ := map:put($options, "uri", $uri)

return $content
};
