#!/bin/bash
#Author: Faheem - SBA Info Solution
#Date Created: 18-08-2020
#Description: The script is written for Enabling Symantec System-Lockdown Module On every Group
#Date Modidfied: 19-08-2020



#######################################################>?Authenticating Symantec For Token<?##########################################################################


AUTHENTICATE="https://192.168.1.20:8446/sepm/api/v1/identity/authenticate"

for auth in $AUTHENTICATE

do
	curl \
    -k -X POST \
    -H "Content-Type: application/json" \
    -d '{"username":"admin", "password":"P@ssw0rd", "domain":""}' \
    $auth \
    -H 'api-version: v1' \
    -so output_token
    Token=$(grep -oP '(?<="token":).*?",' output_token | sed 's/"\|,//g')
    if [ $? -eq 0 ]
    then
	echo
    echo
	echo                                                 ! CONGRATS !
    echo
	echo                                  Token has been successfully imported as a Variable
    echo 
    else
	echo                                                     * HINT *
	echo
	echo                         `1) Check ur Network Communication Between SEPM and your Machine.`
    fi

done


##################################################>? Adding File FingerPrint List To System-LockDown<?##################################################################

ADDING="https://192.168.1.20:8446/sepm/api/v1/policy-objects/fingerprints"

Json_file="Hash-list"

for FingerPrint in $ADDING

do
	curl -k \
    -X POST \
	-H "Authorization: Bearer $Token" \
    -H "Content-Type: application/json" \
	-d @Hash-list \
	$FingerPrint \
	-H 'api-version: v1' \
    -so output_adding
	FingerPrint_id=$(grep -oP '(?<="id":).*?",' output_adding | sed 's/"\|,//g')	
	if [ $? -eq 0 ]
    then
	echo
	echo
	echo                           ^  Success ^
	echo
    echo              :D Added File FingerPrint List :D
    else
	echo                                    * HINT *
    echo
    echo            `2) Kindly Call ur Linux Administrator to Recheck the Script.`
	fi
done

##################################################>? Hosting File FingerPrint List To Every Groups <?##################################################################

Group_id="groupid"

for groupid in $(cat $Group_id)

do
	curl -k \
    -X PUT \
    -H "Authorization: Bearer $Token" \
    -H "Content-Type: application/json" \
    https://192.168.1.20:8446/sepm/api/v1/groups/$groupid/system-lockdown/fingerprints/$FingerPrint_id \
    -H 'api-version: v1' \
    -so output_final 
    if [ $? -eq 0 ]
    then
	echo
	echo
    echo
    echo                               $  ThankYou For Your Patience $
	echo                              
    echo                File FingerPrint List Has been Successfully Posted on Every Group
    echo
	else
    echo                                    * WARNING *
	echo
	echo		        `3) Kindly Contact SBA Scripting Engineers.` 
	echo
    fi
done

#####################################################>? Deleting Respnse Output Files <?################################################################################

	rm -rf output_final output_adding output_token
	echo
	echo -----------------------% Wecome See You Soon %-----------------------------
	echo
