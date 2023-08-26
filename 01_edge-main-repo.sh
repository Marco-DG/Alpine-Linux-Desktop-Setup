# run this script as root

# empty the content of /etc/apk/repositories
truncate -s0 /etc/apk/repositories

# write the repositories
{
        echo "https://dl-cdn.alpinelinux.org/alpine/edge/main"
        echo "# https://dl-cdn.alpinelinux.org/alpine/edge/community"
        echo "# https://dl-cdn.alpinelinux.org/alpine/edge/testing"
} >> /etc/apk/repositories

# update the system
apk update
apk upgradesu