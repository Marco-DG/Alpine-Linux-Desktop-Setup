# How:
#   making a wrapper, called autologin, around /bin/login and putting it in /usr/sbin/
#   editing /etc/inittab specifying the use of /usr/sbin/autologin instead of /bin/login
#
#   we will use tcc as a c compiler (< 1Mb in size (gcc is ~ 120 Mb), only dependency is musl (alredy installed))

# Idea:
#   https://wiki.gumstix.com/index.php/AutoLogin
#   http://littlesvr.ca/linux-stuff/articles/autologinconsole/autologinconsole.php

################################################################
###                 Check root privileges                   ####
################################################################

if [ $EUID > 0 ]
  then echo "The script requires root privileges"
  exit
fi

################################################################
###                   get current user                      ####
################################################################

_username=$(id -u -n)

################################################################
###                     install tcc                         ####
################################################################

apk add --repository https://dl-cdn.alpinelinux.org/alpine/edge/testing tcc
apk add musl-dev # the C standard library

################################################################
###                   write autologin.c                     ####
################################################################

truncate -s0 autologin.c    # clear file
{
        echo "#include <unistd.h>"
        echo ""
        echo "int main()"
        echo "{"
        echo "    execlp('login', 'login', '-f', '$_username', '0);"
        echo "}"
} >> autologin.c

################################################################
###                   compile autologin                     ####
################################################################

tcc -o autologin autologin.c
doas mv autologin /usr/sbin/    # move binary to /usr/sbin

################################################################
###                 editing /etc/inittab                    ####
################################################################

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

# grep: 
# F: Affects how PATTERN is interpreted (fixed string instead of a regex)
# x: Match whole line
# q: Shhhhh... minimal printing
_string_to_search="/usr/sbin/autologin"
if grep -Fxq "$_string_to_search" /etc/inittab
then
    # ERROR
    echo "while searching the file '/etc/inittab' the string '$_string_to_search' has been found within, or an error is occurred"
    echo "as such the script cannot proceed: aborting"
    exit
else
    # backup /etc/inittab
    echo "a backup file called 'inittab.backup' has been created in your home directory"
    doas cp /etc/inittab ~/inittab.backup
    
    # replace ":respawn:/sbin/getty" with ":respawn:/sbin/getty -n -l /usr/sbin/autologin"
    # use "@" as a delimiter
    # -i    Edit file in-place
    doas sed -i 's@:respawn:/sbin/getty@:respawn:/sbin/getty -n -l /usr/sbin/autologin@g' /etc/inittab
fi

unset _string_to_search


################################################################
###                 truncate /etc/motd                      ####
################################################################

doas truncate -s0 /etc/motd # do not display starting message

################################################################
###                         Exit                            ####
################################################################

#rm -f autologin.c # remove autologin.c

unset _username