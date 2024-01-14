#!/bin/sh

set -e

sudo apt install -y gobject-introspection gtk-doc-tools intltool libaccountsservice-dev libgdk-pixbuf2.0-dev libgirepository1.0-dev libgtk-3-dev libpulse-dev libsystemd-dev libxext-dev libxkbfile-dev libxml2-dev libxrandr-dev meson yelp-tools gnome-pkg-tools libcanberra-dev libgl1-mesa-dev libjson-glib-dev libupower-glib-dev libxapp-dev libxt-dev libcanberra-gtk3-dev libcolord-dev libcups2-dev libgudev-1.0-dev liblcms2-dev libnotify-dev libnss3-dev librsvg2-dev libwacom-dev dh-python libpam0g-dev libxdo-dev libmozjs-102-dev libreadline-dev xvfb libgoa-1.0-dev libgoa-backend-1.0-dev libmm-glib-dev libnm-dev libnma-dev dmz-cursor-theme libdrm-dev libgles2-mesa-dev libgbm-dev libgraphene-1.0-dev libinput-dev libnvidia-egl-wayland-dev libpipewire-0.3-dev libstartup-notification0-dev libx11-xcb-dev libxcb-randr0-dev libxcb-res0-dev libxkbcommon-x11-dev xwayland libcjs-dev libgstreamer1.0-dev libmuffin-dev libpolkit-agent-1-dev libxapp-dev libexempi-dev libexif-dev libgail-3-dev libglib2.0-doc libgsf-1-dev libgtk-3-doc libmuffin-dev dbus-x11 xcvt xserver-xorg-core zenity cmake lightdm

mkdir cinnamon
cd cinnamon

git clone https://github.com/linuxmint/cinnamon.git
git clone https://github.com/linuxmint/cinnamon-control-center.git
git clone https://github.com/linuxmint/cinnamon-desktop.git
git clone https://github.com/linuxmint/cinnamon-menus.git
git clone https://github.com/linuxmint/cinnamon-screensaver.git
git clone https://github.com/linuxmint/cinnamon-session.git
git clone https://github.com/linuxmint/cinnamon-settings-daemon.git
git clone https://github.com/linuxmint/cinnamon-translations.git
git clone https://github.com/linuxmint/cjs.git
git clone https://github.com/linuxmint/muffin.git
git clone https://github.com/linuxmint/nemo.git

cd  cinnamon-translations
dpkg-buildpackage -b -uc -us
cd ..

cd  cinnamon-desktop
dpkg-buildpackage -b -uc -us
cd ..

cd cinnamon-menus
dpkg-buildpackage -b -uc -us
cd ..

mkdir stage1
mv *.deb stage1/
cd stage1/
sudo dpkg -i *.deb
sudo apt --fix-broken install -y
cd ..

cd cinnamon-session
dpkg-buildpackage -b -uc -us
cd ..

cd cinnamon-settings-daemon
dpkg-buildpackage -b -uc -us
cd ..

cd cinnamon-screensaver
dpkg-buildpackage -b -uc -us
cd ..

cd cjs
dpkg-buildpackage -b -uc -us
cd ..

mkdir stage2
mv *.deb stage2/
cd stage2/
sudo dpkg -i *.deb
sudo apt --fix-broken install -y
cd ..

cd cinnamon-control-center
dpkg-buildpackage -b -uc -us
cd ..

cd muffin
dpkg-buildpackage -b -uc -us
cd ..

mkdir stage3
mv *.deb stage3/
cd stage3/
sudo dpkg -i *.deb
sudo apt --fix-broken install -y
cd ..

cd cinnamon
dpkg-buildpackage -b -uc -us
cd ..

cd nemo
dpkg-buildpackage -b -uc -us
cd ..

mkdir stage4
mv *.deb stage4/
cd stage4/
sudo dpkg -i *.deb
sudo apt --fix-broken install -y
cd

echo "Done!"
