# checkskew

A bash script to check the clock skew between a system and timeapi.org.  The value of this
is when you are in a hosted environment that you don't have root so you can't tweak the NTP
configuration - so all you can do is monitor and mail yourself a message when clocks
start to skew.

This does assume `curl` and that the UNIX `mail` command is configured to work.  Make sure to test
both commands before trusting this.

Install
-------

The simplest way to install this is just dowload the file - I obly have this in github to accept
pull requests

     curl -O https://raw.githubusercontent.com/csev/checkskew/master/checkskew.sh

Make sure to edit the email and tolerance configuration variables in the script.

I add this to my crontab with a `crontab -e` as follows:

     15 * * * * bash checkskew.sh > /tmp/csev.clockskew.test

Enjoy.
