# Empty the content of /etc/apk/repositories
doas truncate -s0 /etc/apk/repositories
doas echo "https://dl-cdn.alpinelinux.org/alpine/edge/main"
doas echo "# https://dl-cdn.alpinelinux.org/alpine/edge/community"
doas echo "# https://dl-cdn.alpinelinux.org/alpine/edge/testing"
doas apk update
doas apk upgrade