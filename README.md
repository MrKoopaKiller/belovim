# beloVIM
> Beta version v0.9.1

### Dependencies

- brew (just MacOSX)
- python (just MacOSX)
- git
- ack-grep
- exeburant-ctags
- libjson-xs-perl

#### Configuring

  - PowerLine for MacOSX
    Install fonts of https://github.com/powerline/fonts
    Oficial Documentation:
      http://powerline.readthedocs.org/en/master/installation/osx.html
  
  - PowerLine for Ubuntu
    Install fonts of https://github.com/Lokaltog/powerline-fonts/tree/master/UbuntuMono
    Oficial Documentation:
      https://powerline.readthedocs.org/en/latest/installation/linux.html#font-installation

### Install
##### Using Installer
 - beloVIM includes a files called ```install.sh``` just run to install all dependencies.

##### Manual install
- Clone the repository and make a symbolic link of belovim folder and vimrc file to your home folder:
``` ln -s belovim/ $HOME/.vim
    ln -s $HOME/vimrc $HOME/.vimrc
```

### Updating
  Since the version v0.9.0 beloVIM includes a new simple update script.
    Just call the ```update.sh``` to update beloVIM and all submodules.

### Basic Commands
```
  :Ack [pattern]          => Search for a pattern inside project
  :Tabularise /[caracter] => Align the selected text with the choosed caracter
  ,nt                     => Open/Close NerdTree
  ,b                      => Open/Close Method Verifier
  ,be                     => Open/Close Buffer Explorer
  ,bt                     =>Open/Clone Functions panel
  ,p                      => Open installigent seach of files
  ,l                      => Alternates between the last two open files in buffer
  Ctrl+p                  => Press some times to choose what content of buffer do you wish to paste
  Ctrl+←                  => Navegate to left buffer (only linux)
  Ctrl+→                  => Navegate to right buffer (only linux)
  F12                     => Add/Remove line indicators, end line and alters
  :w!!                    => Save file with sudo privileges
```
Fork of 'dotvim' project. See https://github.com/bvicenzo/dotvim for more information
