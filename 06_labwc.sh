###############################################
### ask for root privileges                 ###
###############################################
echo ""
echo "Please provide root access: "
doas -u root ash << EOF

setup-devd udev

apk add mesa-dri-gallium

adduser $USER input
adduser $USER video

apk add font-noto


apk add seatd
rc-update add seatd
rc-service seatd start
adduser $USER seat

apk add labwc

EOF

rm -rf ~/.config/labwc/
mkdir -p ~/.config/labwc
wget https://raw.githubusercontent.com/Marco-DG/Alpine-Linux-Desktop-Setup/master/.config/labwc/environment -O ~/.config/labwc/environment
wget https://raw.githubusercontent.com/Marco-DG/Alpine-Linux-Desktop-Setup/master/.config/labwc/autostart -O ~/.config/labwc/autostart
wget https://raw.githubusercontent.com/Marco-DG/Alpine-Linux-Desktop-Setup/master/.config/labwc/menu.xml -O ~/.config/labwc/menu.xml
wget https://raw.githubusercontent.com/Marco-DG/Alpine-Linux-Desktop-Setup/master/.config/labwc/rc.xml -O ~/.config/labwc/rc.xml


mkdir ~/.cache


