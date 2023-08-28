###############################################################
###             Check that user is not root                 ###
###############################################################

if [ "$(id -u)" -eq 0 ]
    then echo "This script cannot be executed by root"
    exit 1
fi

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

doas truncate -s0 /etc/profile

###############################################
### write /etc/profile                      ###
###############################################
{
    echo 'export PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"'
    echo ""
    echo "export ENV=\$HOME/.configs/ash/.ashrc"
    echo ""
    echo "for script in /etc/profile.d/*.sh ; do"
    echo -e -n "\t"; echo   'if [-r "\$script" ] ; then'
    echo -e -n "\t\t"; echo     '. "\$script"'
    echo -e -n "\t"; echo   "fi"
    echo "done"
    echo "unset script"
    echo ""
} >> /etc/profile

###############################################
### drop root privileges                    ###
###############################################
EOF

###############################################################
###             ~/.configs/ash/.ashrc                       ###
###############################################################
mkdir -p $HOME/.configs/ash/
wget https://raw.githubusercontent.com/Marco-DG/Alpine-Linux-Desktop-Setup/master/.configs/ash/.ashrc  -P $HOME/.configs/ash/

###############################################################
###             ~/.logs/ash/.ash_history                    ###
###############################################################
mkdir -p $HOME/.logs/ash
mv -f $HOME/.ash_history $HOME/.logs/ash/

exec ash
rm -f $HOME/.ash_history

#doas -u $(id -u -n) ash << EOF
#    rm -f $HOME/.ash_history
#EOF

unset _to_nuke_or_not_to_nuke_that_is_the_question