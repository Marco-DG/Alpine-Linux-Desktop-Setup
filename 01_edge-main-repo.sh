################################################################
###                 Check root privileges                   ####
################################################################

if [ "$(id -u)" -ne 0 ]
    then echo "This script requires root privileges"
    exit 1
fi

################################################################
###                 Edit /etc/apk/repositories              ####
################################################################

# empty the content of /etc/apk/repositories
truncate -s0 /etc/apk/repositories

# write the repositories
{
        echo "https://dl-cdn.alpinelinux.org/alpine/edge/main"
        echo "# https://dl-cdn.alpinelinux.org/alpine/edge/community"
        echo "# https://dl-cdn.alpinelinux.org/alpine/edge/testing"
} >> /etc/apk/repositories

################################################################
###                     Update the system                   ####
################################################################

apk update
apk upgrade