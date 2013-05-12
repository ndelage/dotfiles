#!/bin/bash

DIR=~/projects/dotfiles/

mkdir -p ~/dotfiles_old

cd $DIR
for i in *
do
    echo "Linking $i"
    mv ~/.$i ~/dotfiles_old/
    ln -s $DIR/$i ~/.$i
done
