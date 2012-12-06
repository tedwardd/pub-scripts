#!/bin/bash

## This will set your backlight based on reading from the ambient light sensor
## This should work for most modern Macbooks and Macbook Air models as well as
## work with most modern distributions of Linux since, I think, the /sys/devices
## are setup the same these days.
##
## Author: Ted Wood (elw)
## Date: 2012-12-06
## Version: 0.1

#### NOTES
## This is going to take a lot of tweaking. As long as it's in a pre v.1.0
## I'll likely have to play around with the settings to get it right. For now
## I've just divided 255 by 15 (max ambient sensor value by max screen
## brightness) and the light will change linearly... this is likely to work
## pretty terribly, I'll probably need to do some kind of exponential curve
## to make the screen visible at levels above 35 or 40.
##
## I will remove all of the "DEBUG USE" lines once I'm happier with this script
## as well. Ultimately you'll want to run this as a daemon at startup but for
## now you have to launch it manually after login.

## Most of the variables here aren't needed.
## I'll remove them when I'm closer to being finished
minAmbientVal=1		# Min ambient light sensor value
maxAmbientVal=255	# Max ambient light sensor value

minBackVal=1		# Min backlight brightness value
maxBackVal=15		# Max backlight brightness value

devicesPath=/sys/devices
appleSMCPath=$devicesPath/platform/applesmc.768

checkInterval=10
updateInterval=0.5

stateChange=true
while :
do

	currAmbientVal=$(cat $appleSMCPath/light | awk -F, '{print $1}' | sed -e 's/(//g')
	echo $currAmbientVal # DEBUG USE
	if (( 1 <= $currAmbientVal && $currAmbientVal <= 17 )); then
		echo '1' > $devicesPath/pci0000\:00/0000\:00\:02.0/backlight/acpi_video0/brightness
		echo "Backlight value set to 2" # DEBUG USE
	elif (( 18 <= $currAmbientVal && $currAmbientVal <= 34 )); then
		echo '2' > $devicesPath/pci0000\:00/0000\:00\:02.0/backlight/acpi_video0/brightness
		echo "Backlight value set to 2" # DEBUG USE
	elif (( 35 <= $currAmbientVal && $currAmbientVal <= 51 )); then
		echo '3' > $devicesPath/pci0000\:00/0000\:00\:02.0/backlight/acpi_video0/brightness
		echo "Backlight value set to 3" # DEBUG USE
	elif (( 52 <= $currAmbientVal && $currAmbientVal <= 68 )); then
		echo '4' > $devicesPath/pci0000\:00/0000\:00\:02.0/backlight/acpi_video0/brightness
		echo "Backlight value set to 4" # DEBUG USE
	elif (( 69 <= $currAmbientVal && $currAmbientVal <= 85 )); then
		echo '5' > $devicesPath/pci0000\:00/0000\:00\:02.0/backlight/acpi_video0/brightness
		echo "Backlight value set to 5" # DEBUG USE
	elif (( 86 <= $currAmbientVal && $currAmbientVal <= 102 )); then
		echo '6' > $devicesPath/pci0000\:00/0000\:00\:02.0/backlight/acpi_video0/brightness
		echo "Backlight value set to 6" # DEBUG USE
	elif (( 103 <= $currAmbientVal && $currAmbientVal <= 119 )); then
		echo '7' > $devicesPath/pci0000\:00/0000\:00\:02.0/backlight/acpi_video0/brightness
		echo "Backlight value set to 7" # DEBUG USE
	elif (( 103 <= $currAmbientVal && $currAmbientVal <= 119 )); then
		echo '7' > $devicesPath/pci0000\:00/0000\:00\:02.0/backlight/acpi_video0/brightness
		echo "Backlight value set to 7" # DEBUG USE
	elif (( 120 <= $currAmbientVal && $currAmbientVal <= 136 )); then
		echo '8' > $devicesPath/pci0000\:00/0000\:00\:02.0/backlight/acpi_video0/brightness
		echo "Backlight value set to 8" # DEBUG USE
	elif (( 137 <= $currAmbientVal && $currAmbientVal <= 153 )); then
		echo '9' > $devicesPath/pci0000\:00/0000\:00\:02.0/backlight/acpi_video0/brightness
		echo "Backlight value set to 9" # DEBUG USE
	elif (( 154 <= $currAmbientVal && $currAmbientVal <= 170 )); then
		echo '10' > $devicesPath/pci0000\:00/0000\:00\:02.0/backlight/acpi_video0/brightness
		echo "Backlight value set to 10" # DEBUG USE
	elif (( 171 <= $currAmbientVal && $currAmbientVal <= 187 )); then
		echo '11' > $devicesPath/pci0000\:00/0000\:00\:02.0/backlight/acpi_video0/brightness
		echo "Backlight value set to 11" # DEBUG USE
	elif (( 188 <= $currAmbientVal && $currAmbientVal <= 204 )); then
		echo '12' > $devicesPath/pci0000\:00/0000\:00\:02.0/backlight/acpi_video0/brightness
		echo "Backlight value set to 12" # DEBUG USE
	elif (( 205 <= $currAmbientVal && $currAmbientVal <= 221 )); then
		echo '13' > $devicesPath/pci0000\:00/0000\:00\:02.0/backlight/acpi_video0/brightness
		echo "Backlight value set to 13" # DEBUG USE
	elif (( 222 <= $currAmbientVal && $currAmbientVal <= 238 )); then
		echo '14' > $devicesPath/pci0000\:00/0000\:00\:02.0/backlight/acpi_video0/brightness
		echo "Backlight value set to 14" # DEBUG USE
	elif (( 239 <= $currAmbientVal && $currAmbientVal <= 255 )); then
		echo '15' > $devicesPath/pci0000\:00/0000\:00\:02.0/backlight/acpi_video0/brightness
		echo "Backlight value set to 15" # DEBUG USE
	fi	
	sleep $checkInterval
done
