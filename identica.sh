#!/bin/bash
#
# Author: Ted Wood (ted.l.wood@gmail.com)
# Date: 2011-06-23
#
# There are two sections to this script. 
# Section 1 will prompt you for your username, password and status seperately 
# so that you don't have to leave your credintials hard coded to the script.
# Section 2 will allow you to hard code your username and password so that
# you can use the following syntax to post an update: "identica.sh foo status".

## Section 1

# You can hard code your username in the line below to save some typing.
username="Your_Username"

read -p "Enter identi.ca username [$username]: " username2
if [ ! -z $username2 ]
	then
	username=$username2
fi

while [ -z $pass ]; do
	read -p "Enter identi.ca password: " pass
done

while [ -z $status ]; do
	read -p "Status update: " status
done

curl -u $username:$pass -d status="$status" https://identi.ca/api/statuses/update.xml

## End Section 1

## Section 2
#
# If you choose to use section 2 instead of section 1 please be careful.
# I recommend setting the file permissions to 700 w/ "chmod 700 identica.sh"
#
################### 
## User Settings (edit these to match your information)
#username="Some_User"
#pass="Some_pass"
####################
#
#curl -u $username:$pass -d status="$1" https://identi.ca/api/statuses/update.xml
