#!/usr/bin/env bash

BASH="$HOME/git/home"
cd $BASH

export DROPBOX_HOME=~/Dropbox/home/noorul

# Backup existing conf files
export BASH_BACKUP_DIR="/tmp/home"
mkdir -p $BASH_BACKUP_DIR

for file in $(ls -a $BASH_BACKUP_DIR| grep -v '^.$' | grep -v '^..$')
do
    rm -rf "$BASH_BACKUP_DIR/$file"
done

for conf_file in $BASH/configs/*
do
    mv -f $HOME/.${conf_file##*/} $BASH_BACKUP_DIR
done

# Install config files
for conf_file in $BASH/configs/*
do
    ln -s $conf_file $HOME/.${conf_file##*/}
done

# Backup private config files
for conf_file in $(ls -a $DROPBOX_HOME| grep -v '^.$' | grep -v '^..$')
do
    mv -f $HOME/${conf_file##*/} $BASH_BACKUP_DIR
done

# Install private config files
for conf_file in $(ls -a $DROPBOX_HOME| grep -v '^.$' | grep -v '^..$')
do
    ln -s $DROPBOX_HOME/$conf_file $HOME
done

cp $BASH/template/bash_profile.debian.template.bash $HOME/.bash_profile
cp $BASH/template/bashrc.debian.template.bash $HOME/.bashrc

cp $HOME/.bash_profile $BASH_BACKUP_DIR
cp $HOME/.bashrc $BASH_BACKUP_DIR
