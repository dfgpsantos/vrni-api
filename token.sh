#!/bin/bash

#please remove your credentials info after using the script

rm -rf *.txt

cat > user.txt << EOL
{
  "username": "userhere@domainhere.com",
  "password": "yourpasswordhere",
  "domain": {
    "domain_type": "LDAP",
    "value": "corp.com"
  }
}
EOL

curl -i -s -k -b cookie.txt -D header.txt -H "Content-Type: application/json" --data @user.txt -X POST https://$VRNI/api/ni/auth/token | grep token > token.txt

rm -rf user.txt

cat token.txt
