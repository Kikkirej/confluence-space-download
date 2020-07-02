#!/bin/sh

if [[ -z "$USRNAME" ]]; then
   echo USRNAME nicht gesetzt
   exit 1
fi

if [[ -z "$USRPWD" ]]; then
   echo USRPWD nicht gesetzt
   exit 1
fi

if [[ -z "$SPACE_KEY" ]]; then
   echo SPACE_KEY nicht gesetzt
   exit 1
fi

if [[ -z "$CONFBASEURL" ]]; then
   echo CONFBASEURL nicht gesetzt
   exit 1
fi

# From https://jira.atlassian.com/browse/CONFSERVER-40457?_ga=2.48376294.1129510111.1593587912-1418901574.1572616581

JSON=`curl -s -k \
    --user $USRNAME:$USRPWD \
    -H "Content-Type: application/json" \
    -H "Accept: application/json" \
    -X POST \
    -d '{ "jsonrpc" : "2.0", "method" : "exportSpace", "params" : ["'${SPACE_KEY}'", "TYPE_HTML"], "id": 7 }' \
    ${CONFBASEURL}'/rpc/json-rpc/confluenceservice-v2?os_authType=basic'`
echo  ermitteltes Json: $JSON
URL=`echo $JSON | awk 'BEGIN{FS="\""}{print $6}'`
echo URL: $URL

if [[ -n "$NOT_ROUTABLE_HOST" ]]; then
    # URL=${$URL/$ROUTABLE_HOST/$NOT_ROUTABLE_HOST}
    URL=`echo $URL | sed s/${NOT_ROUTABLE_HOST}/${ROUTABLE_HOST}/g`
    echo angepasste URL: $URL
fi

curl -LO -k --user $USRNAME:$USRPWD -X GET $URL

FILENAME=`echo $URL | awk 'BEGIN{FS="/"}{print $7}'`
echo Filename: $FILENAME

rm -rf /export/$SPACE_KEY
unzip $FILENAME
rm -f $FILENAME
cp -R $SPACE_KEY/* /export/