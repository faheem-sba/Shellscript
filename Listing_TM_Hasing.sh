#!/bin/bash
#Author: SBA 
#Date Created: 05-03-2021
#Description: The script is written for listing hasing TM(dsm) 
#Date Modidfied: 06-03-2021

ID="/root/test/id"
URL="https://192.168.1.41:4119/api/applicationcontrolglobalrules/search"
KEY="B767F7CB-53FC-4ED0-6D18-6CBF10343234:mBReZzNkoCVVYwlagxXDoAzNgn/uJ9uCrqFaWbrXwZU="

for id in $(cat $ID)

do
        Response=$(curl \
        -X POST \
        -H "Content-Type: application/json" \
        -d '{ "maxItems": 1,"searchCriteria": [ { "idValue": '$id' } ], "sortByObjectID": true }' \
        $URL \
        -H "api-secret-key: $KEY" \
        -H 'api-version: v1' \
	    --insecure)
	    if [ $? = 0 ]
        then
        echo
        else
        echo 
        fi
        echo $Response

done
