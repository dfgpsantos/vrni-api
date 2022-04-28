#!/bin/bash

VRNIUSER='"user@corp.local"'
# please inform the password by system variable export VRNIPASS='"yourpassword"'
DOMAINTYPE='"LDAP"'
DOMAINVALUE='"corp.local"'
VRNI=vrni.corp.local

#please remove your credentials info after using the script

rm -rf *.txt

cat > user.txt << EOL
{
  "username": $VRNIUSER,
  "password": $VRNIPASS,
  "domain": {
    "domain_type": $DOMAINTYPE,
    "value": $DOMAINVALUE
  }
}
EOL

curl -i -s -k -b cookie.txt -D header.txt -H "Content-Type: application/json" --data @user.txt -X POST https://$VRNI/api/ni/auth/token | grep token > token.txt
rm user.txt
export VRNIPASS=passwordclear
echo $VRNIPASS
cat token.txt
