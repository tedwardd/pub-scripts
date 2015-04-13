#! /usr/bin/env python

## This is one of my first Python scripts, HERE BE DRAGONS
## 
## This script should, if it works properly, generate the specified number of
## randomly generated passwords of a specified length. Both the number and
## lengths are specified during runtime.

import os, random, string

# Set count eq to some value greater than 0 to start the loop
count = 1
while count > 0:
    # Ask for how many
    count = raw_input("How many should we generate: ")
    # break if the user types exit or quit
    if count == "EXIT" or count == "exit" or count == "quit" or count == "q":
        break
    # break if the user enters 0 for the count value
    if int(count) < 1:
        break
    # Prompt for password length
    length = int(raw_input("How long should they be: "))
    # What are valid characters to include in the password
    chars = string.ascii_letters + string.digits + '!@#$%^&*()'
    # Set the random seed value
    random.seed = (os.urandom(20480))
    # set a secondary variable eq to the int value of $count
    count2 = int(count)
    # start our loop of passwords to generate
    while count2 > 0:
        count2 = count2 - 1
        # join char together in a random order
        print ''.join(random.choice(chars) for i in range(length))
# Break when finished
print "Good bye!"
