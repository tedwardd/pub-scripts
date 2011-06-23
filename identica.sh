#!/bin/bash
#
# Author: Ted Wood (ted.l.wood@gmail.com)
# Date: 2011-06-23
#
# Take the input from $2, prompt for a password and then push $2 to identi.ca.
# This is done using curl and identi.ca API. Adjust the information in the
# section labeled "USER INFO" before using this script.

# ********************
# **** USER INFO ***** 
# ********************
username="Username" #

# *****************************************************************************
# ******* You don't need to edit anything below here if you don't want. *******
# *****************************************************************************
status=$2
post() {
	if [ "$username" = "Username" ]
		then
		echo "You need to edit $0 and add your username to the "USER INFO" section before you can use the script."
		exit 1
	fi
	# Prompt user for password and hide user input
	stty -echo
		while [ -z $pass ]
			do
		read -p "Enter your password: " pass
		done
	stty echo

	# Pass the information to curl
	curl -u $username:$pass -d status="$status" https://identi.ca/api/statuses/update.xml
}
case "$1" in
	post|update)
		post
		;;
	*)
		echo -e $"Usage: $0 {post|update} \"Text to post\"\n\tPost the text inside of the quotes."
		RETVAL=1
esac
