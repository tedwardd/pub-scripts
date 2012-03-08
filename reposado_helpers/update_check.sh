#!/bin/bash

#
# This script assumes you have a dedicated user for reposado.
# It also makes the assumption that the repo_sync and repoutil files
# exist in ~/code (as if reposado's ~/ were the git repo root).
# I've included some sections which are commented out if your setup is different
#

# Reposado user, change if necessary
RUSER=reposado
# Change user.emailN@website.com to to be a space seperated list of email addresses to receive update notifications
RECIPIENTS="user.email1@website.com user.email2@website.com user.email3@website.com"

# If the user above's home directory is not root of the reposado root directory
# switch out the following lines and set the directory manually.
#
# REPOSADOROOTDIR=/path/to/code/directory
REPOSADOROOTDIR=$(getent passwd $RUSER | cut -d: -f6)

###################################
### DO NOT EDIT BELOW THIS LINE ###

# Check for updates first
$REPOSADOROOTDIR/code/repo_sync

$REPOSADOROOTDIR/code/repoutil --updates | /bin/cut -d[ -f1 > $REPOSADOROOTDIR/newupdate.txt

if [ ! -f $REPOSADOROOTDIR/previousupdate.txt ]; then
  echo -e "$REPOSADOROOTDIR/previousupdate.txt does not exist. Please run: \n\t\t$REPOSADOROOTDIR/code/repoutil --updates | cut -d[ -f1 > $REPOSADOROOTDIR/previousupdate.txt"
  exit 1
fi

$REPOSADOROOTDIR/code/repoutil --updates | cut -d[ -f1 > $REPOSADOROOTDIR/newupdate.txt

if ! diff $REPOSADOROOTDIR/newupdate.txt $REPOSADOROOTDIR/previousupdate.txt > $REPOSADOROOTDIR/availableupdates.txt ; then
for addr in $RECIPIENTS; do
  /bin/mail -s "New Mac Updates Downloaded" $addr < $REPOSADOROOTDIR/availableupdates.txt
done
fi

rm -f $REPOSADOROOTDIR/previousupdate.txt

mv $REPOSADOROOTDIR/newupdate.txt $REPOSADOROOTDIR/previousupdate.txt

