#!/bin/sh

# kde5-plasma-antu.sh: install/update Antü Plasma Suite [1], an
# "elegant Alternative Suite for Plasma 5" by Fabián Alexis.
# 
# The installation is made inside $HOME/.local/share.
#
# [1] https://github.com/fabianalexisinostroza/Antu

# Copyright © 2016 Antonio Hernández Blas <hba.nihilismus@gmail.com>
# This work is free. You can redistribute it and/or modify it under the
# terms of the Do What The Fuck You Want To Public License, Version 2,
# as published by Sam Hocevar. See http://www.wtfpl.net/ for more details.

git_antu=https://github.com/Zeirison/Antu

mkdir -p $HOME/.local/share/tmp || exit 1
cd $HOME/.local/share/tmp || exit 1

if [ -f Antu/.git/config ]; then
  echo
  echo " => Updating Antu: $HOME/.local/share/tmp/Antu"
  echo
  cd Antu
  git pull origin master || exit 1
  echo
  cd ..
else
  echo
  echo " => Downloading Antu: $HOME/.local/share/tmp/Antu"
  echo
  rm -rf Antu
  git clone $git_antu || exit 1
  echo
fi

echo " => Installing icons ..."
mkdir -p $HOME/.local/share/icons || exit 1
cd $HOME/.local/share/icons || exit 1

ls -1d ../tmp/Antu/Icons/Antu* | while read dir; do
  ln -sf "$dir" .
done

echo " => Installing window decorations ..."
mkdir -p $HOME/.local/share/kwin/decorations || exit 1
cd $HOME/.local/share/kwin/decorations || exit 1

ls -1d ../../tmp/Antu/Decorations/Kwin/* | while read dir; do
  ln -sf "$dir" .
done

echo " => Installing theme ..."
mkdir -p $HOME/.local/share/plasma/desktoptheme || exit 1
cd $HOME/.local/share/plasma/desktoptheme || exit 1

ls -1d ../../tmp/Antu/Antu*Plasma*Theme*/* | while read dir; do
  ln -sf "$dir" .
done

echo " => Installing color schemes ..."
mkdir -p $HOME/.local/share/color-schemes || exit 1
cd $HOME/.local/share/color-schemes || exit 1

ls -1d ../tmp/Antu/Color*Schemes*/* | while read dir; do
  ln -sf "$dir" .
done

echo " => Installing wallpapers ..."
mkdir -p $HOME/.local/share/wallpapers || exit 1
cd $HOME/.local/share/wallpapers || exit 1

ls -1d ../tmp/Antu/Wallpapers/* | while read dir; do
  ln -sf "$dir" .
done

echo " => Done"
echo
echo " => IMPORTANT: do not edit/modify any file inside $HOME/.local/share/tmp/Antu"
echo
