#!/bin/bash

# Reload Library
alias reload='source ~/.bash_profile'

# Load colors first so they can be use in base theme
source "${BASH}/themes/colors.theme.bash"
source "${BASH}/themes/base.theme.bash"

# Library
LIB="${BASH}/lib/*.bash"
for config_file in $LIB
do
  source $config_file
done

# Load enabled aliases, completion, plugins
for file_type in "aliases" "completion" "plugins"
do
  if [ -d $BASH/$file_type ]; then
      FILES="${BASH}/${file_type}/*.bash"
      for config_file in $FILES
      do
          source $config_file
      done
  fi
done

unset config_file
if [[ $PROMPT ]]; then
    export PS1=$PROMPT
fi
