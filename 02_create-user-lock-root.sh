# run this script as root

# -n 
#      do not output a trailing newline.
echo -n "Enter the username: "
read -r _username

echo -n "Enter the password: "
read -s _password

adduser --home /home/"$_username" $_username # --shell bash

#--stdin
#      This option is used to indicate that passwd should read the new
#      password from standard input, which can be a pipe.
echo "$_password" | passwd "$_username" --stdin

adduser $_username wheel

# delete and lock root password
passwd -d root
passwd -l root

unset _username
unset _password

apk add doas

exit