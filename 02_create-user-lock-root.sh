# run this script as root

################################################################
###                     Add User                            ####
################################################################

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

adduser --gecos "$_username" $_username     \
        --disabled-password                 \
        $_username

################################################################
###                         doas                            ####
################################################################

adduser $_username wheel

apk add doas > /dev/null # "> /dev/null" makes it silent

touch /etc/doas.d/doas.conf
echo "permit persist :wheel" >> /etc/doas.d/doas.conf

################################################################
###                     User Password                       ####
################################################################

echo -n "Enter the password: "
read -s _password
echo ""

echo $_username:$_password | chpasswd

################################################################
###                       Lock root                         ####
################################################################

passwd -d -l root

################################################################
###                         Exit                            ####
################################################################

echo "run: 'exit' and then login again as '$_username'"

unset _username
unset _password