#!/bin/bash
# beloVIM install for linux and macosx
# rabeloo.com

function base_install() {
  echo -ne "\t+ Installing base files...\n"
  git clone https://github.com/Shougo/neobundle.vim bundle/neobundle.vim
}

function fonts_install() {

  if [ -d ./fonts ]; then
    rm -rf ./fonts
  fi

  $(git clone https://github.com/powerline/fonts.git)

  powerline_fonts_dir=$( cd "$( dirname "$0" )" && pwd )
  find_command="find \"$powerline_fonts_dir\" \( -name '*.[o,t]tf' -or -name '*.pcf.gz' \) -type f -print0"

  if [[ `uname` == 'Darwin' ]]; then
    font_dir="$HOME/Library/Fonts"
  else
    font_dir="$HOME/.fonts"
    mkdir -p $font_dir
  fi

  eval $find_command | xargs -0 -I % cp "%" "$font_dir/"

  if [[ -n `which fc-cache` ]]; then
    fc-cache -f $font_dir
  fi
  echo -ne "\t+ Powerline fonts installed to $font_dir\n"
}

function mac_install() {
  echo -ne "\t+ Checking dependencies...\n"
  brew install python ctags ack homebrew/dupes/ncurses

  # call base_install function
  base_install

  echo -ne "\t+ Getting powerline fonts...\n"
  # Call fonts_install function
  fonts_install

  echo "************* IMPORTANT ************

  Please change the font of your current profile in iTerm2:

  In iTerm2 go to:

  1. Preferences > Profile
  2. Select the text tab
  3. Change the Regular and Non-ASCII using fonts for Powerline:

  Suggest: 14pt Inconsolata for Powerline

  Enjoy it!
  Thanks!
  ***********************************"
  #call initialize function
  initialize
  # call make_alias function
  make_alias
}

function linux_install() {
  base_install

  if [ -f /usr/bin/apt-get ]; then
    packager="apt-get"
    packs="exuberant-ctags ack ncurses-term libjson-xs-perl"
  elif [ -f /usr/bin/yum ]; then
    packager="yum"
    packs="git ctags-etags ack ncurses-term perl-JSON-XS"
  else
    echo "ERR: Package Manager not indentified. Please install manually."
    exit 1
  fi

  echo "Installing pre-requisites..."
  for pack in $packs; do
    sudo $packager install $pack -y
  done

  # call base_install function
  base_install

  echo "Configuring VIM..."
  if [ ! -d ~/.fonts/ ]; then
   mkdir ~/.fonts
   if [ ! -f ~/.fonts/PowerlineSymbols.otf ]; then
     wget "https://github.com/Lokaltog/powerline/raw/develop/font/PowerlineSymbols.otf"
     mv PowerlineSymbols.otf ~/.fonts/
   fi
  fi
  if [ ! -d ~/.config/fontconfig/conf.d/ ]; then
   mkdir -p ~/.config/fontconfig/conf.d/
   if [ ! -f ~/.config/fontconfig/conf.d/10-powerline-symbols.conf ]; then
     wget "https://github.com/Lokaltog/powerline/raw/develop/font/10-powerline-symbols.conf"
     mv 10-powerline-symbols.conf ~/.config/fontconfig/conf.d/
   fi
  fi
  #call initialize function
  initialize
  # call make_alias function
  make_alias
}

function make_alias() {
  # Create symbolic link
  if [ -e ~/.vimrc ]; then
    unlink ~/.vimrc
  fi
  if [ -e ~/.vim ]; then
    unlink ~/.vim
  fi
  if [ ! -e ~/.vimrc ]; then
    ln -s $(pwd)/vimrc ~/.vimrc
  fi
  if [ ! -e ~/.vim ]; then
    ln -s $(pwd) ~/.vim
  fi
}

function initialize() {
  echo -ne "\t+ Initializing...\n"
  vim +NeoBundleInstall +qall
}

if [[ $(uname) == 'Darwin' ]]; then
  mac_install
else
  linux_install
fi
