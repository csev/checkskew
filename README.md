# checkskew

A bash script to check the clock skew between a system and `timeapi.org`.  The value of this
is when you are in a hosted environment that you don't have root so you can't tweak the NTP
configuration - so all you can do is monitor and mail yourself a message when clocks
start to skew and bug the system admin to fix the clock before all your security stuff goes haywire.

This does assume `curl` and that the UNIX `mail` command is configured to work.  Make sure to test
both commands before trusting this.

The primary reason I bult this is that when using IMS Learning Tools Interoperability (and other
OAuth/HMac based security patterns) - when clocks get too far skewed (i.e. > 300 seconds)
everything breaks down.

Install
-------

I have this in github to accept pull requests if folks find bugs and/or make improvements.
The simplest way to install this is just dowload the file. 

     curl -O https://raw.githubusercontent.com/csev/checkskew/master/checkskew.sh
  
or
     wget --no-check-certificate https://raw.githubusercontent.com/csev/checkskew/master/checkskew.sh

Make sure to edit the email and tolerance configuration variables in the script.

I add this to my crontab with a `crontab -e` as follows:

     15 * * * * bash checkskew.sh > /tmp/csev.clockskew.test

Enjoy.
