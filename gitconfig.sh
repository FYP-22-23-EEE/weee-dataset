#!/bin/sh

function ssh-keygen() {
    ssh-keygen -o -t rsa -C "$EMAIL"
    echo "------------------ KEY ----------------------"
    cat .ssh/id_rsa.pub
    echo "---------------------------------------------"
}

function setup-agent() {
    eval "$(ssh-agent -s)"
    ssh-add -k .ssh/id_rsa
}

# local .ssh folder
mkdir .ssh && cd .ssh

EMAIL="thilina.18@cse.mrt.ac.lk"
NAME="Thilina Lakshan"

# git config
git config user.name "$NAME"
git config user.email "$EMAIL"
git config core.editor "vim"

# setup alias
git config alias.co checkout
git config alias.br branch
git config alias.ci commit
git config alias.st status

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

setup-agent



