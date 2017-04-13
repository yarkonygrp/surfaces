#!/bin/bash

# Make archive for JCP submission.

string=$(pwd);
echo "Curent directory: $string"
if [[ $string != *"surfaces" ]]; then
    echo "Must be in /path/to/surfaces/directory!"
    exit
fi

if [ "$1" == "" ]; then
    echo "Must give name of system!"
    exit
fi

system=$1
if [ ! -d "$string/$system" ]; then
    echo "Must give valid name of system!"
    exit
fi

if [ "$2" == "" ]; then
    echo "Must give name of surface!"
    exit
fi

surface=$2
if [ ! -d "$string/$system/$surface" ]; then
    echo "Must give valid surface!"
    echo "$surface does not exist in $string/$system!"
    exit
fi

newdir="$system.$surface"
mkdir $newdir
cp -r evalsurf $newdir/
cp -r $string/$system/$surface $newdir/surface/

tar cvf $newdir.tar $newdir

