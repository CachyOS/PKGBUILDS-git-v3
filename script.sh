#!/usr/bin/env bash

rm -rf *-git

paru -G \
contour-git \
cutefish-git \
disman-git \
exa-git \
fastfetch-git \
fbneo-git \
ffmpeg-git \
kwinft-git \
lapce-git \
gamescope-git \
xorg-xwayland-git \
spectrwm-git \
mold-git \
hyprland-git \
mesa-git \
lib32-mesa-git \


files=$(find . -name "PKGBUILD")

for f in $files
do
        d=$(dirname $f)
        cd $d
        docker run --name ci-build-v3 -e EXPORT_PKG=1 -e CHECKSUMS=1 -e SYNC_DATABASE=1 -e IGNORE_ARCH=1 -v $PWD:/pkg -v /home/ptr1337/ccache:/home/notroot/.buildcache pttrr/docker-makepkg-v3
        docker rm ci-build-v3
        cd ..
done

mv */*.tar.zst* /home/ptr1337/.docker/build/nginx/www/repo/x86_64_v3/cachyos-v3
update-repo-v3
repoctl update -P cachyos-v3
