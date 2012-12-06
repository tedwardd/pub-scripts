### Lightctl
#####Lightctl is a script that is designed to work with late model Macbook Air and Macbook Pro models. It uses the input from the ambient light sensor and adjusts the backlight and keyboard brightness levels dynamically. Lightctl should work with most major/modern Linux distributions. Until I've finalized things a bit more, however, I would suggest reading over the script and making sure that the locations that it's expecting exist on your system.

#### TODO List:
    * Adjust thresholds to improve backlight transition smoothness
    * Add Keyboard brightness controls
    * Create systemd conf file to start lightctl as a daemon

#### Changelog:
    * Thu Dec 06 2012 Ted Wood <ted.l.wood@gmail.ccom> - 0.1
    - First release of lightctl with basic functionality
