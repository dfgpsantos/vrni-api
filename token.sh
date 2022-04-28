#!/bin/bash

VRNIUSER='"user@corp.local"'
DOMAINTYPE='"LDAP"'
DOMAINVALUE='"corp.local"'
VRNI=field-demo.vrni.cmbu.local
QUOTES='"'
read -s -p "Password: " VRNIPASS

#please remove your credentials info after using the script

rm -rf *.txt

cat > user.txt << EOL
{
  "username": $VRNIUSER,
  "password": $QUOTES$VRNIPASS$QUOTES,
  "domain": {
    "domain_type": $DOMAINTYPE,
    "value": $DOMAINVALUE
  }
}
EOL

curl -i -s -k -b cookie.txt -D header.txt -H "Content-Type: application/json" --data @user.txt -X POST https://$VRNI/api/ni/auth/token | grep token > token.txt

cat token.txt

VRNIPASS=passwordcleared
echo $VRNIPASS

rm user.txt
