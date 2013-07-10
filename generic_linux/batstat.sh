## Author: Ted Wood
## Email: ted.l.wood@gmail.com
## Date: 2012-10-04
###############################################################################
## Since the acpitool project page has been down for some time, I've re-written
## This utility to use the generic acpi utility. You can get this from
## slackbuilds.org, if you are running slackware, or from your distributions'
## prefered package management system.
#
## If you wish to use the acpitool method instead of the acpi method, uncomment
## out the "ACPITOOL" section and comment out the "NO ACPITOOL" section.
#
###############################################################################

### ACPICONF
# This will work on BSD systems that use the acpiconf utility instead of acpitool
# You may have to change "0" to reflect the ID of your battery if not "0"
percent=$(acpiconf -i 0 | grep "Remaining capacity:" | awk '{print $3}')
time=$(acpiconf -i 0 | grep "Remaining time:" | awk '{print $3}')
echo "${percent} | ${time}"
#
### ACPITOOL
#acpitool -B | grep Remaining | awk '{print $6 " " $7}'
#
### NO ACPITOOL

##Check if plugged in
##plug=$(acpi -a | awk '{print $3}')

## If not plugged in, show time remaining
##if [ $plug == "off-line" ]; then
##acpi -b | awk -F, '{print $2 $3}' | awk '{print $1" - "$2}'
#If plugged in, only show percentage
#elif [ $plug == "on-line" ]; then
#acpi -b | awk '{print $4}'
#This should never happen, but if it does, add a condition for it
#else
#echo "NULL"
#fi
