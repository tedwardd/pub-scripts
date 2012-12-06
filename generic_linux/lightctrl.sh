#!/bin/bash

## This will set your backlight based on reading from the ambient light sensor

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
	if (( 1 <= $currAmbientVal && $currAmbientVal <= 25 )); then
		echo '2' > $devicesPath/pci0000\:00/0000\:00\:02.0/backlight/acpi_video0/brightness
		echo "Backlight value set to 2" # DEBUG USE
	elif (( 26 <= $currAmbientVal && $currAmbientVal <= 50 )); then
		echo '7' > $devicesPath/pci0000\:00/0000\:00\:02.0/backlight/acpi_video0/brightness
		echo "Backlight value set to 7" # DEBUG USE
	fi	
	sleep $checkInterval
done
