###############################################################
###                 Check root privileges                   ###
###############################################################

if [ "$(id -u)" -ne 0 ]
    then echo "This script requires root privileges"
    exit 1
fi

###############################################################
###                     Add User                            ###
###############################################################

# echo:
#       -n	Do not output a trailing newline.
#       -e	Enable interpretation of backslash escape sequences 
# read:
#       -r	Disable backslashes to escape characters.
#       -s	Does not echo the user's input.
echo -n "Enter the username: "
read -r _username


# adduser [OPTIONS] USER [GROUP]
# 
# Create new user, or add USER to GROUP
# 
#      -h --home DIR           Home directory
#      -g --gecos GECOS        GECOS field
#      -s --shell SHELL        Login shell named SHELL by example /bin/bash
#      -G --ingroup GRP        Group (by name)
#      -S --system             Create a system user
#      -D --disabled-password  Don't assign a password, so cannot login
#      -H --no-create-home     Don't create home directory
#      -u --uid UID            User id
#      -k SKEL                 Skeleton directory (/etc/skel)

# note: -g "<Full Name>" sets the GECOS field.
#        setting this string - at least equal to the username - makes the user distinguishable,
#         e.g. when they are listed at the login screen of a display manager.

adduser --gecos "$_username"     \
        --disabled-password      \
        --home "/home/$_username/" \
        $_username

###############################################################
###                         doas                            ###
###############################################################

adduser $_username wheel

apk add doas > /dev/null # "> /dev/null" makes it silent

touch /etc/doas.d/doas.conf
# nopass: do not ask password ever.
# persist:  do not ask for a password again for some time.
echo "permit nopass :wheel" >> /etc/doas.d/doas.conf            # https://man.openbsd.org/doas.conf.5

###############################################################
###                     User Password                       ###
###############################################################

echo -n "Enter the password: "
read -s _password
echo ""

echo $_username:$_password | chpasswd

###############################################################
###                       Lock root                         ###
###############################################################

passwd -d -l root

###############################################################
###                  Move Home Directory                    ###
###############################################################

cp -a /root/. /home/$_username/
chown -R $_username /home/$_username

rm -rf /root/*

###############################################################
###                         Exit                            ###
###############################################################
su -l user 


unset _username
unset _password
