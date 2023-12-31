### How:
#       by adding the '--quiet' flag to each '/sbin/openrc' command within '/etc/inittab'

###############################################################
###                 Check root privileges                   ###
###############################################################

#if [ "$(id -u)" -ne 0 ]
#    then echo "This script requires root privileges"
#    exit 1
#fi

###############################################################
###                 ask for root privileges                 ###
###############################################################

echo "Please provide root access: "
doas -u root ash << EOF

###############################################################
###                 Parallelizing Boot                      ###
###############################################################

### NOTE on 'Parallelize Boot':
# see: https://unix.stackexchange.com/questions/579013/how-to-improve-startup-time-of-openrc-system
#
# even tough many have reported speedups due to parallelization,
# personally I didn't experience any noticeable improvement
#
# INFO: when 'rc_parallel = "YES"' the aesthetic changes, the text is prompted differently.

if grep -q \#rc_parallel=\"NO\" /etc/rc.conf; then
    # uses "@" as a delimiter; the '-i' flag edits the file in-place
    doas sed -i 's@#rc_parallel="NO"@rc_parallel="YES"@g' /etc/rc.conf
else
    echo "WARNING: unable to find the string '#rc_parallel=\"NO\"' in /etc/rc.conf"
fi

###############################################################
###                     Silencing Boot                      ###
###############################################################
# sed: uses "@" as a delimiter; the '-i' flag edits the file in-place

# openrc sysinit
if grep -q "openrc sysinit --quiet" /etc/inittab; then
    echo "WARNING: the file '/etc/inittab' alredy contains the string 'openrc sysinit --quiet', as such the script will not commit any changes and it adivised to check the '/etc/inittab' integrity manually."
else
    doas sed -i 's@openrc sysinit@openrc sysinit --quiet@g' /etc/inittab
fi

# openrc boot
if grep -q "openrc boot --quiet" /etc/inittab; then
    echo "WARNING: the file '/etc/inittab' alredy contains the string 'openrc boot --quiet', as such the script will not commit any changes and it adivised to check the '/etc/inittab' integrity manually."
else
    doas sed -i 's@openrc boot@openrc boot --quiet @g' /etc/inittab
fi

# openrc default
if grep -q "openrc default --quiet" /etc/inittab; then
    echo "WARNING: the file '/etc/inittab' alredy contains the string 'openrc default --quiet', as such the script will not commit any changes and it adivised to check the '/etc/inittab' integrity manually."
else
    doas sed -i 's@openrc default@openrc default --quiet@g' /etc/inittab
fi

# openrc shutdown
if grep -q "openrc shutdown --quiet" /etc/inittab; then
    echo "WARNING: the file '/etc/inittab' alredy contains the string 'openrc shutdown --quiet', as such the script will not commit any changes and it adivised to check the '/etc/inittab' integrity manually."
else
    doas sed -i 's@openrc shutdown@openrc shutdown --quiet@g' /etc/inittab
fi

EOF

### NOTES
#   the --quiet flag alone does not suppress all the messages:
#       - errors are still displayed, to disable them, repeat the flag twice: --quiet --quiet (according to the documentation, difficult to test)
#       - fcsk still display messages, to disable them, redirect them to /dev/null (or perhaps it would be better to log them) :
#           openrc boot --quiet >> /dev/null
#       - networking message are still displayed, I don't know hot to disable them
#       - busybox messages are still displayed during shutdown and reboot because they are hardcoded in the binary, more info at:
#           https://github.com/mirror/busybox/blob/master/init/init.c
#           https://github.com/open-power/op-build/issues/2385
#       - "Welcome to Alpine" is defined in /etc/issue, to disable it truncate the file (In my case the current configuration already hides it)

