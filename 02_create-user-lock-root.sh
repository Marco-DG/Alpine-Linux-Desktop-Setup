# run this script as root

_create-user-lock-root()
{
    # -n 
    #      do not output a trailing newline.
    echo -n "Enter the username: "
    read -r _username

    if "$_username" | grep -E '^[a-z_]([a-z0-9_-]{0,31}|[a-z0-9_-]{0,30}\$)$' -q; then
        return 1
    fi

    echo -n "Enter the password: "
    read -s _password

    adduser --home /home/"$_username" $_username # --shell bash

    #--stdin
    #      This option is used to indicate that passwd should read the new
    #      password from standard input, which can be a pipe.
    echo "$_password" | passwd "$_username" --stdin

    adduser $_username wheel

    unset _username
    unset _password
}

_create-user-lock-root
unset _create-user-lock-root