#!/bin/bash

DATASET_LINK="https://zenodo.org/record/6420886/files/dataset.zip?download=1"

function install_aria2() {
    # if apt avaliable use it 
    if [ -x "$(command -v apt)" ]; then
        sudo apt install aria2
    # if pacman avaliable use it
    elif [ -x "$(command -v pacman)" ]; then
        sudo pacman -S aria2
    # if dnf avaliable use it
    elif [ -x "$(command -v dnf)" ]; then
        sudo dnf install aria2
    fi
}

if [ ! -f /usr/bin/aria2c ]; then
    printf "aria2 not found, install it now? [Y/n] "
    read -r answer
    if [ "$answer" = "Y" ] || [ "$answer" = "y" ] || [ "$answer" = "" ]; then
        install_aria2
    else
        exit 1
    fi
fi

# if data/v1 already exists exit 
if [ -d data/v1 ]; then
    printf "data/v1 already exists, do you want to overwrite it? [Y/n] "
    read -r answer
    if [ "$answer" = "Y" ] || [ "$answer" = "y" ] || [ "$answer" = "" ]; then
        rm -rf data/v1
    else
        exit 1
    fi
fi

mkdir data
aria2c $DATASET_LINK -o data/dataset.zip
unzip data/dataset.zip -d data/temp
mv data/temp/dataset data/v1
rm -rf data/temp

