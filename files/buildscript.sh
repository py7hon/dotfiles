#!/bin/sh

export LANG=C
pacman --noconfirm -Syu --needed archiso
pacman -Scc --noconfirm
rm ${PROFILE}/profiledef.sh
cp ./files/profiledef.sh ${PROFILE}
cp -r ./dotfiles/. ${PROFILE}/airootfs/root

tee -a ${PROFILE}/pacman.conf <<- 'EOF'
[home_iqbalrifai_Arch]
Server = https://download.opensuse.org/repositories/home:/iqbalrifai/Arch/$arch
SigLevel = Optional Never
EOF

# Add packages
tee -a ${PROFILE}/packages.x86_64 <<EOF
microsoft-edge-dev-bin
EOF

# Build ISO
mkarchiso -v -o 'public' $PROFILE
sha256sum public/* > public/sha256sum.txt


