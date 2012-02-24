#!/bin/bash

# This script will generate a random password of the user specified length
# Length definied by $1

if [ -z "$1" -o "$1" = "0" ]; then
	echo -e "Usage: $0 disired_length\n\t\tYou must include the desired length.\n\t\tThe length can be any numeric value other than zero.\n"
else
	password="$(tr -dc "[:alnum:]" < /dev/urandom | head -c $1)";
	echo -e "\n$password\n"
fi
