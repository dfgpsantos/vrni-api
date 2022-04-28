#!/bin/bash

#please replace the entity_id with the ones that you want to monitor

echo "Please select the metric you want to monitor"
echo ""
echo "1 - CPU usage"
echo "2 - Memory usage"
echo "3 - Disk commited space"
echo "4 - Network usage"
echo "5 - Bytes Rx average"
echo "6 - Bytes Tx average"
echo "7 - PPS Rx average"
echo "8 - PPS Tx average"
echo "9 - PPS Total average"

read -p "Choose 1 - 9 " -n 1 -r CHOICE

echo ""

if [[ $CHOICE == 1 ]]
then
METRIC='"cpu.usage.rate.average.percent"'
fi

if [[ $CHOICE == 2 ]]
then
METRIC='"mem.usage.absolute.average.percent"'
fi

if [[ $CHOICE == 3 ]]
then
METRIC='"storage.committed.absolute.latest.bytes"'
fi

if [[ $CHOICE == 4 ]]
then
METRIC='"net.usage.rate.average.kiloBitsPerSecond"'
fi

if [[ $CHOICE == 5 ]]
then
METRIC='"net.received.rate.average.kiloBitsPerSecond"'
fi

if [[ $CHOICE == 6 ]]
then
METRIC='"net.transmitted.rate.average.kiloBitsPerSecond"'
fi

if [[ $CHOICE == 7 ]]
then
METRIC='"net.ppsRx.rate.average.number"'
fi

if [[ $CHOICE == 8 ]]
then
METRIC='"net.ppsTx.rate.average.number"'
fi

if [[ $CHOICE == 9 ]]
then
METRIC='"net.ppsTotal.rate.average.number"'
fi

awk -F '"' '{ print $4 }' token.txt 1> /dev/null


TOKEN=`awk -F '"' '{ print $4 }' token.txt`
#echo $TOKEN

cat > test2.txt << EOL
{
  "entity_ids": [
    "10000:1:381096877044883491"
  ],
  "metric": $METRIC,
  "interval":300,
  "start_time":1651073950,
  "end_time":1651160350
}
EOL

curl -s -k -H "Authorization: NetworkInsight $TOKEN" -H "Content-Type: application/json" -H "Accept: application/json" -X POST 'https://field-demo.vrni.cmbu.local/api/ni/metrics/fetch/v2' -d @test2.txt


rm -rf text2.txt
