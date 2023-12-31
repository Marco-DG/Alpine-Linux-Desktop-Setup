###############################################################
###             Check that user is not root                 ###
###############################################################

if [ "$(id -u)" -eq 0 ]
    then echo "This script cannot be executed by root"
    exit 1
fi

_home=$HOME

###############################################################
###                 edit /etc/profile                       ###
###############################################################

###############################################
### nuke /etc/profile                       ###
###############################################
echo -n "ATTENTION !!! '/etc/profile/ will be nuked, digit 'y' to continue, any other key will exit: "
read -r _to_nuke_or_not_to_nuke_that_is_the_question
[ "$_to_nuke_or_not_to_nuke_that_is_the_question" != "y" ] && exit 1

###############################################
### ask for root privileges                 ###
###############################################
echo ""
echo "Please provide root access: "
doas -u root ash << EOF

truncate -s0 /etc/profile

###############################################
### write /etc/profile                      ###
###############################################
{
    echo 'export PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"'
    echo ""
    echo "export ENV=$_home/.config/ash/.ashrc"
    echo ""
    echo "for script in /etc/profile.d/*.sh ; do"
    echo -e -n "\t"; echo   'if [ -r "\$script" ] ; then'
    echo -e -n "\t\t"; echo     '. "\$script"'
    echo -e -n "\t"; echo   "fi"
    echo "done"
    echo "unset script"
    echo ""
} >> /etc/profile

###############################################################
###                     apk add afetch                      ###
###############################################################

#apk add afetch --repository https://dl-cdn.alpinelinux.org/alpine/edge/testing

###############################################
### drop root privileges                    ###
###############################################
EOF

###############################################################
###                 ~/.config/ash/.ashrc                   ###
###############################################################
mkdir -p $_home/.config/ash/
rm -f $_home/.config/ash/.ashrc
wget https://raw.githubusercontent.com/Marco-DG/Alpine-Linux-Desktop-Setup/master/.config/ash/.ashrc  -P $_home/.config/ash/

###############################################################
###             ~/.logs/ash/.ash_history                    ###
###############################################################
mkdir -p $_home/.logs/ash
mv -f $_home/.ash_history $_home/.logs/ash/

###############################################################
###                         Exit                            ###
###############################################################
su -l user 

unset _home
unset _to_nuke_or_not_to_nuke_that_is_the_question
