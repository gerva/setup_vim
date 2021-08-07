#!/bin/bash

set -e

cd "$( dirname "$0")"

CURRENT_DIR="$(pwd)"
GITHUB="https://github.com"
MINPACK_REPO="$GITHUB/k-takata/minpac.git"
MINPACK_DST="$HOME/.vim/pack/minpac/opt/minpac"

function install_minpack {
   mkdir -p $(dirname "$MINPACK_DST")
   if [ ! -e "$MINPACK_DST" ]
   then
     echo "* cloning minpac repo"
     git clone "$MINPACK_REPO" "$MINPACK_DST" > /dev/null 2>&1
   else
     echo "* updating minpac repo"
     (cd "$MINPACK_DST" && git pull > /dev/null 2>&1)
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

function neovim_setup {
   NEOVIM_CONF_DIR="$HOME/.config/nvim"
   mkdir -p "$NEOVIM_CONF_DIR"
   cp _neovim "$NEOVIM_CONF_DIR/init.vim"
}

install_minpack
neovim_setup
create_link _vimrc
echo "* done, open vi and execute 'call minpac#update()'"
