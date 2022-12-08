#!/bin/sh

EMAIL="thilina.18@cse.mrt.ac.lk"
NAME="Thilina Lakshan"

git config --global user.name "$NAME"
git config --global user.email "$EMAIL"


mkdir ~/.ssh 
cd ~/.ssh 
ssh-keygen -o -t rsa -C "$EMAIL"

# add config file 
touch config
tee config <<EOF
Host *
    AddKeysToAgent yes
    UseKeychain yes
    IdentityFile ~/.ssh/id_rsa 
EOF

# add key to ssh-agent
ssh-add -K ~/.ssh/id_rsa

# print public key
echo "---------------------------------------------"
cat ~/.ssh/id_rsa.pub
echo "---------------------------------------------"

