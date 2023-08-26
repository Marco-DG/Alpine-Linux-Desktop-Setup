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

# the optional -g "<Full Name>" above sets the GECOS field.
# setting this string - at least equal to the username - makes the user distinguishable,
# e.g. when they are listed at the login screen of a display manager.
adduser --gid "$_username" $_username   \
        --home /home/"$_username"       \
        --shell ash
        $_username

################################################################
###                         doas                            ####
################################################################

adduser $_username wheel

apk add doas

################################################################
###                     User Password                       ####
################################################################

echo -e "\n"
echo -n "Enter the password: "
read -s _password

#echo $_username:$_password | chpasswd
echo "$password" | passwd "$username" --stdin


################################################################
###                     Lock root                           ####
################################################################

# delete and lock root password
passwd -d -l root


################################################################
###                         Exit                            ####
################################################################

unset _username
unset _password

exit