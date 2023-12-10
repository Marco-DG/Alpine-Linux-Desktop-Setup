doas setup-devd udev

apk add mesa-dri-gallium

doas adduser $USER input
doas adduser $USER video

apk add font-dejavu


apk add seatd
rc-update add seatd
rc-service seatd start
adduser $USER seat

apk add labwc

mkdir -p ~/.config/labwc
wget https://raw.githubusercontent.com/labwc/labwc/master/docs/environment -O ~/.config/labwc/environment
wget https://raw.githubusercontent.com/labwc/labwc/master/docs/autostart -O ~/.config/labwc/autostart
wget https://raw.githubusercontent.com/labwc/labwc/master/docs/menu.xml -O ~/.config/labwc/menu.xml
wget https://raw.githubusercontent.com/labwc/labwc/master/docs/rc.xml -O ~/.config/labwc/rc.xml


