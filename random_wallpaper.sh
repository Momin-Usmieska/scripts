#!/bin/bash
source /home/momin/.config/scripts/imageAt.txt
num=$(echo $imageAT)

nitrogen --set-zoom-fill  ~/Wallpaper/$num.jpg

if [[ $num <=34 ]]; then
  num=$((num+1));
else
  num=1;
fi

sed -i 's/imageAT=.*/imageAT='$num'/' /home/momin/.config/scripts/imageAt.txt
