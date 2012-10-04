#!/bin/bash
#
# This script is designed to be run from either /etc/bashrc or ~/.bashrc
# Checks if user has a directory in /var/ftp/pub, if not, it creates one
# Checks if user has a symlink to their /var/ftp/pub directory in $HOME, if not, one is created
#
# Author: Ted Wood (twood8)
# Date: 2011-11-15
#

# set $uname to value of current username
uname=$(whoami)
# by default we'll set $cn to the format of Firstname_Lastinitial
cn=$(getent passwd $uname | cut -d: -f5 | sed -re 's/^(\w+) (\w\.)? (\w).*/\1\_\3/')
# if you would prefer lastname.firstname, comment out the line above and
# uncomment out the line below:
# cn=$(getent passwd $uname | cut -d: -f5 | sed -re 's/^(\w+) (\w\.)? (\w+).*/\3\.\1/')

if [ "$uname" != "root" ] # Ensure user is not running as root
    then
      if [ ! -e /var/ftp/pub/$cn ] # Ensure public FTP directory does not yet exist
      then
        mkdir /var/ftp/pub/$cn
	chmod 755 /var/ftp/pub/$cn
	chown $uname.users /var/ftp/pub/$cn
      fi
      if [ ! -e $HOME/pub-ftp ] # Ensure symlink to pub FTP directory does not exist
      then
        ln -s /var/ftp/pub/$cn /users/$uname/pub-ftp # Create it if it's missing
      fi
fi
