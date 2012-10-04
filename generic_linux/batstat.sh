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

### ACPITOOL
#acpitool -B | grep Remaining | awk '{print $6 " " $7}'

### NO ACPITOOL
acpi -b | awk -F, '{print $2 $3}' | awk '{print $1" - "$2}'
