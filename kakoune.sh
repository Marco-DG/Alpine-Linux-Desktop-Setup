apk add --repository https://dl-cdn.alpinelinux.org/alpine/edge/community kakoune
apk add --repository https://dl-cdn.alpinelinux.org/alpine/edge/testing kakoune-lsp

rm -rf ~/.config/kak/
mkdir -p ~/.config/kak
mkdir -p ~/.config/kak/colors
wget https://raw.githubusercontent.com/Marco-DG/Alpine-Linux-Desktop-Setup/master/.config/kak/kakrc -O ~/.config/kak/kakrc
wget https://raw.githubusercontent.com/Marco-DG/Alpine-Linux-Desktop-Setup/master/.config/kak/colors/kak.kak -O ~/.config/colors/kak.kak
wget https://raw.githubusercontent.com/Marco-DG/Alpine-Linux-Desktop-Setup/master/.config/kak/colors/kak-in.kak -O ~/.config/colors/kak-in.kak
