# empty the content of /etc/apk/repositories
doas truncate -s0 /etc/apk/repositories

# write the repositories
doas echo "https://dl-cdn.alpinelinux.org/alpine/edge/main" > /etc/apk/repositories
doas echo "# https://dl-cdn.alpinelinux.org/alpine/edge/community" > /etc/apk/repositories
doas echo "# https://dl-cdn.alpinelinux.org/alpine/edge/testing" > /etc/apk/repositories

# update the system
doas apk update
doas apk upgrade