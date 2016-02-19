#!/usr/bin/env bash

command -v curl >/dev/null 2>&1 || { echo >&2 "Please install curl first"; exit 1; }
ldfApi="http://ldf.lodlaundromat.org"
endpoint="http://sparql.backend.lodlaundromat.org/"
downloadUrl="http://download.lodlaundromat.org"
resourceUrl="http://lodlaundromat.org/resource"
r2dIndex="http://index.lodlaundromat.org/get/r2d/"
ns2dIndex="http://index.lodlaundromat.org/get/ns2d/"

construct="PREFIX llo: <http://lodlaundromat.org/ontology/> CONSTRUCT { ?s llo:url ?u } WHERE { { ?s llo:url ?u_aux ; llo:triples ?t . BIND(STR(?u_aux) AS ?u) } UNION { ?a llo:url ?u_aux ; llo:containsEntry ?s . ?s llo:path ?p . BIND(CONCAT(?u_aux,\"#\",?p) AS ?u) } }"

limit=50    
offset=0

while true; do
        limitOffset="LIMIT $limit OFFSET $offset";

        query="$construct $limitOffset"

        result=$(curl $curlUserAgent -X POST -s "$endpoint"  --data-urlencode "query=$query" -H 'Accept: text/csv' | sed '1d');

        while read -r line; do
            if [ -z "$line" ]; then
                #just whitespace string
                continue
            fi
            document=$(echo "$line"   | sed 's/^\"\([^\"]*\)\".*/\1/')
            uri=$(echo "$line" | sed 's/.*\"\([^\"]*\)\"$/\1/')
            echo "$document $uri";
        done <<< "$result"
        if [ -z "$result" ]; then
            #no results left, we are done!
            exit 0;
        fi

        offset=`expr $offset + $limit`
done