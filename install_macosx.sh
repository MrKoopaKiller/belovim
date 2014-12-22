#!/bin/bash
# MacOSX install by rabeloo
## raphael at rabeloo dot com dot br

echo -ne "\t+ Check dependencies..."
brew install ctags ncurses-term ack-grep

echo -ne "\t+ Getting powerline fonts... "

if [ -d .fonts ]; then
  rm -rf ./fonts
fi

$(git clone https://github.com/powerline/fonts.git)

echo -ne "\t+ Installing fonts powerline fonts... "
((./fonts/install.sh))

echo -ne "\t+ Instalando Plugins..."
$(git submodule update --init)

echo -ne "\t+ Finishing installation..."
$(ln -s ./vimrc ~/.vimrc)

echo "************* IMPORTANT ************

Please change the font of your current profile in iTerm2:

 In iTerm2 go to:
 
1. Preferences > Profile
2. Select the text tab
3. Change the Regular and Non-ASCII using fonts for Powerline:

Suggest: 15pt Inconsolata for Powerline

Now, is time to enjoy! =)
Thanks!
***********************************"
