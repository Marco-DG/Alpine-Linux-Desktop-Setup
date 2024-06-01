###############################################
### ask for root privileges                 ###
###############################################
echo ""
echo "Please provide root access: "
doas -u root ash << EOF

apk add --repository https://dl-cdn.alpinelinux.org/alpine/edge/community kakoune
apk add --repository https://dl-cdn.alpinelinux.org/alpine/edge/testing kakoune-lsp

EOF

rm -rf ~/.config/kak/
mkdir -p ~/.config/kak
mkdir -p ~/.config/kak/colors
wget https://raw.githubusercontent.com/Marco-DG/Alpine-Linux-Desktop-Setup/master/.config/kak/kakrc -P ~/.config/kak/
wget https://raw.githubusercontent.com/Marco-DG/Alpine-Linux-Desktop-Setup/master/.config/kak/colors/kak.kak -P ~/.config/kak/colors/
wget https://raw.githubusercontent.com/Marco-DG/Alpine-Linux-Desktop-Setup/master/.config/kak/colors/kak-in.kak -P ~/.config/kak/colors/
