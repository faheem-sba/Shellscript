#!/bin/bash
#Author: Faheem - SBA Info Solution 
#Date Created: 10-08-2020
#Description: The script is written for hasing TM(dsm) 
#Date Modidfied: 17-08-2020

HASH="/home/user/hash"
URL="https://app.deepsecurity.trendmicro.com/api/applicationcontrolglobalrules"
KEY="39B33CE9-63AC-65EB-C13B-D2E9483DA498:E3B800AC-AFDA-EE4C-0663-6023CEE15B11:FpeQp+t+UnNzJKJ1CsrdUba97aYWIsU51dvs1oEx6TY="

for hash in $(cat $HASH)

do
        Response=$(curl \
        -X POST \
        -H "Content-Type: application/json" \
        -d '{"applicationControlGlobalRules": [{"sha256": "'$hash'", "description": "string"}]}' \
        $URL \
        -H "api-secret-key: $KEY" \
        -H 'api-version: v1')
        if [ $? = 0 ]
        then
        echo
        echo \"Hash Value Blocked\"
        echo
        else
        echo Script Didnt execute
        fi
        echo $Response


done >> output
