#!/usr/bin/env bash

BASH="$HOME/projects/home"
cd $BASH

export DROPBOX_HOME=~/Dropbox/home/noorul

# Backup existing conf files
export BASH_BACKUP_DIR="/tmp/home"
mkdir -p $BASH_BACKUP_DIR

for file in $(ls -a $BASH_BACKUP_DIR| grep -v '^.$' | grep -v '^..$')
do
    echo rm -rf "$BASH_BACKUP_DIR/$file"
done

for conf_file in $BASH/conf/*
do
    echo mv -f $HOME/.${conf_file##*/} $BASH_BACKUP_DIR
done

# Install config files
for conf_file in $BASH/conf/*
do
    echo ln -s $conf_file $HOME/.${conf_file##*/}
done

# Install private config files
for conf_file in $(ls -a $DROPBOX_HOME| grep -v '^.$' | grep -v '^..$')
do
    echo ln -s $DROPBOX_HOME/$conf_file $HOME/${conf_file}
done

git submodule sync
git submodule update --init

cd $BASH/conf/emacs.d
git submodule sync
git submodule update --init

cd $BASH
