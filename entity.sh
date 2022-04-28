#!/bin/bash

awk -F '"' '{ print $4 }' token.txt


TOKEN=`awk -F '"' '{ print $4 }' token.txt`
echo $TOKEN

cat > entity.txt << EOL
{
  "entities": [
    {
      "entity_id": "10000:1:381096877044883491",
      "time": 0
    }
  ]
}
EOL

curl -i -v -k -H "Authorization: NetworkInsight $TOKEN" -H "Content-Type: application/json" -H "Accept: application/json" -X POST 'https://field-demo.vrni.cmbu.local/api/ni/entities/names' -d @entity.txt

rm -rf entity.txt
