#!/bin/bash

cd "$( dirname "$0")"

CURRENT_DIR="$(pwd)"
GITHUB="https://github.com"
VIM_BUNDLE_DIR="$HOME/.vim/bundle"

function sync_repo {
   mkdir -p "$VIM_BUNDLE_DIR"
   REPO_NAME=$1
   LOCAL_REPO_NAME="$(echo "$REPO_NAME" | sed 's!.*/!!' | sed 's/\.git//')"
   echo " * $LOCAL_REPO_NAME"
   LOCAL_DIR="$VIM_BUNDLE_DIR/$LOCAL_REPO_NAME"
   if [ -e "$LOCAL_DIR" ] 
   then
       cd "$LOCAL_DIR"
       git pull origin master > /dev/null 2&>1
       git submodule update --init --recursive > /dev/null 2&>1
   else
       cd "$VIM_BUNDLE_DIR"
       git clone "$GITHUB/$REPO_NAME" > /dev/null 2>&1
       git submodule update --init --recursive > /dev/null 2>&1
   fi
}

function create_link {
    local SRC="$CURRENT_DIR/$1"
    local DST="$HOME/${1/_/.}"

    if [ -e "${DST}" ] && [ ! -L "${DST}" ]; then
        mv "$DST" "backup/$DST-$(date +%s).backup"
    fi

    ln -sf "$SRC" "$DST"
}


# installing pathogen
echo "Installing pathogen"
mkdir -p ~/.vim/autoload ~/.vim/bundle; \
curl -Sso ~/.vim/autoload/pathogen.vim \
    https://raw.github.com/tpope/vim-pathogen/master/autoload/pathogen.vim

# installing from github
echo "Installing vim plugins:"
sync_repo scrooloose/nerdtree.git
sync_repo hdima/python-syntax.git
sync_repo altercation/vim-colors-solarized.git
sync_repo klen/python-mode.git
sync_repo millermedeiros/vim-statline.git

# backup and updating vimrc
create_link _vimrc
