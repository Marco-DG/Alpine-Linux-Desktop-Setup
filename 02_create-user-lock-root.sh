# run this script as root

# create user
echo -n "Enter the username: "
read -r _username

echo -n "Enter the password: "
read -s _password

echo -e ""

adduser --home /home/"$_username" $_username \
        --ingroup wheel # --shell bash

echo $_username:$_password | chpasswd

# delete and lock root password
passwd -d -l root

unset _username
unset _password

# install doas
apk add doas

exit