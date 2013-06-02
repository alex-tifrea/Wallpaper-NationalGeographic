#!/bin/bash
cd ~/Pictures/
mkdir National_Geographic_POD
mkdir Saved_pictures_natgeo
folder=~/Pictures/National_Geographic_POD

cd $folder
sudo rm index* *jpg
POD="http://photography.nationalgeographic.com/photography/photo-of-the-day/?source=NavPhoPOD"
wget -nc $POD -P $folder
adr=$(ls | grep [^a])
var=$(cat $adr | tr -s '\n' | grep -i 'go to the previous' -n | cut -d ':' -f1)

wget -nc -P $folder $(cat $adr | tr -s '\n' | head -n $((var+1)) | tail -1 | cut -d "\"" -f2)

rm index*

PICTURE=$(ls *jpg)
gsettings set org.gnome.desktop.background picture-uri file://~/Pictures/National_Geographic_POD/$PICTURE

if test $# -eq 1; then
    if test $1 = "-s" -o $1 = "--save-image"; then
        cp *.jpg ../Saved_pictures_natgeo/
    else
        echo "natgeo.sh: Invalid argument"
        exit 1
    fi
fi

if test $# -gt 1; then
        echo "natgeo.sh: Too many arguments"
        exit 2
fi

exit 0
