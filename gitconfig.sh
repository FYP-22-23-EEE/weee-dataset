#!/bin/sh

function ssh-keygen() {
    ssh-keygen -o -t rsa -C "$EMAIL"
    echo "------------------ KEY ----------------------"
    cat .ssh/id_rsa.pub
    echo "---------------------------------------------"
}

function sync-ssh-dir() {
    cp -r ~/.ssh ../.ssh
}

function setup-agent() {
    eval "$(ssh-agent -s)"
    ssh-add -K ~/.ssh/id_rsa
}

# local .ssh folder
mkdir .ssh && cd .ssh

EMAIL="thilina.18@cse.mrt.ac.lk"
NAME="Thilina Lakshan"

# git config
git config --global user.name "$NAME"
git config --global user.email "$EMAIL"
git config --global core.editor "vim"

# generate ssh key
# check if .ssh/id_rsa and .ssh/id_rsa.pub already exists
if [ -f ~/.ssh/id_rsa ] && [ -f ~/.ssh/id_rsa.pub ]; then
    echo "SSH key already exists"
    printf "Do you want to overwrite? [y/N]: "
    read -r answer
    if [ "$answer" == "y" ]; then
        ssh-keygen
    fi
else 
    ssh-keygen
fi

sync-ssh-dir
setup-agent


