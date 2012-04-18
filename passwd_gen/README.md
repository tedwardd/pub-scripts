## Random Password Generator v.1.0.0
##### Author: *Ted W. < ted.l.wood@gmail.com >*

------------------------------------------------------------------------------

This script will attempt to use /dev/urandom to generate a random string of
characters. The length of the password generated is based on the value of $1
(see examples below).

##### Examples:
* Generate a 12 character password

        passwd_gen.sh 12

------------------------------------------------------------------------------

#### Known Issues:
* Script does not work under Mac OS X (tested in OS X 10.7.3)
* Output shows some characters as "?" under OS X Lion using Gentoo Prefix

------------------------------------------------------------------------------

#### Todo List:
* Fix issues under OS X
* Add support for outputing a user specified number of passwords per run.
