# beloVIM
> Beta version v0.86

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
- in progress...

### Basic Commands
```
  :Ack [pattern]          => Search for a pattern inside project
  :Tabularise /[caracter] => Align the selected text with the choosed caracter
  ,nt                     => Open/Close NerdTree
  ,b                      => Open/Close Method Verifier
  ,be                     => Open/Close Buffer Explorer
  ,p                      => Open installigent seach of files
  Ctrl+p                  => Press some times to choose what content of buffer do you wish to paste
  Ctrl+←                  => Navegate to left buffer
  Ctrl+→                  => Navegate to right buffer
  F12                     => Add/Remove line indicators, end line and alters
```
Fork of 'dotvim' project. See https://github.com/bvicenzo/dotvim for more information
