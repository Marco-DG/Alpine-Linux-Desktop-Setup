# How:
#   making a wrapper, called autologin, around /bin/login and putting it in /usr/sbin/
#   editing /etc/inittab specifying the use of /usr/sbin/autologin instead of /bin/login
#
#   we will use tcc as a c compiler (< 1Mb in size (gcc is ~ 120 Mb), only dependency is musl (alredy installed))

# Idea:
#   https://wiki.gumstix.com/index.php/AutoLogin
#   http://littlesvr.ca/linux-stuff/articles/autologinconsole/autologinconsole.php

###############################################################
###             Check that user is not root                 ###
###############################################################

if [ "$(id -u)" -eq 0 ]
    then echo "This script cannot be executed by root"
    exit 1
fi

###############################################################
###                   get current user                      ###
###############################################################

_username=$(id -u -n)


###############################################################
###                 ask for root privileges                 ###
###############################################################

echo "Please provide root access: "
doas -u root ash << EOF

###############################################################
###                     install tcc                         ###
###############################################################

apk add --repository https://dl-cdn.alpinelinux.org/alpine/edge/testing tcc
apk add musl-dev # the C standard library

###############################################################
###                   write autologin.c                     ###
###############################################################

truncate -s0 autologin.c    # clear file
{
        echo "#include <unistd.h>"
        echo ""
        echo "int main()"
        echo "{"
        echo "    execlp(\"login\", \"login\", \"-f\", \"$_username\", 0);"
        echo "}"
} >> autologin.c

###############################################################
###                   compile autologin                     ###
###############################################################

tcc -o autologin autologin.c
doas mv autologin /usr/sbin/    # move binary to /usr/sbin

###############################################################
###                 editing /etc/inittab                    ###
###############################################################

# getty [OPTIONS] BAUD_RATE TTY [TERMTYPE]
# 
# Open a tty, prompt for a login name, then invoke /bin/login
# 
# Options:
# 
#         -h              Enable hardware (RTS/CTS) flow control
#         -i              Do not display /etc/issue before running login
#         -L              Local line, do not do carrier detect
#         -m              Get baud rate from modem"s CONNECT status message
#         -w              Wait for a CR or LF before sending /etc/issue
#         -n              Do not prompt the user for a login name
#         -f ISSUE_FILE   Display ISSUE_FILE instead of /etc/issue
#         -l LOGIN        Invoke LOGIN instead of /bin/login
#         -t SEC          Terminate after SEC if no username is read
#         -I INITSTR      Send INITSTR before anything else
#         -H HOST         Log HOST into the utmp file as the hostname   

# check if the file is been modified already
if grep -q /usr/sbin/autologin /etc/inittab; then
    echo "WARNING: the file '/etc/inittab' alredy contains the string ':respawn:/sbin/getty -n -l /usr/sbin/autologin', as such the script will not commit any changes and it adivised to check the '/etc/inittab' integrity manually."
else
    # replace ":respawn:/sbin/getty" with ":respawn:/sbin/getty -n -l /usr/sbin/autologin"
    # uses "@" as a delimiter; the '-i' flag edits the file in-place
    doas sed -i 's@:respawn:/sbin/getty@:respawn:/sbin/getty -n -l /usr/sbin/autologin@g' /etc/inittab
fi

###############################################################
###                 truncate /etc/motd                      ###
###############################################################

doas truncate -s0 /etc/motd # do not display starting message

###############################################################
###                         Exit                            ###
###############################################################
EOF

rm -f autologin.c # remove autologin.c

unset _username