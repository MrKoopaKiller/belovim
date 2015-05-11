# belovim
vimrc
> v2.0.0

### Prerequisites
- brew (just MacOSX)
- git

### Dependencies

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

### Easier Install
##### Using Installer
- belovim includes a files called ```install.sh``` just run to install all dependencies.

##### Manual install
- Clone the repository and make a symbolic link of belovim folder and vimrc file to your home folder:
```
$ ln -s belovim/ $HOME/.vim
$ ln -s $HOME/vimrc $HOME/.vimrc
```
- Installing all modules with:
```
$ vim +NeoBundleInstall +qall
```

### Customs key mappings

#### Follow the leader!
```
  Leader key             => <Space>
```

#### Managing open files
```
  <leader> + y          => Copy to system clipboard
  <leader> + p          => Paste the system clipboard
  <shift>  + <          => Navegate to left buffer
  <shift>  + >          => Navegate to right buffer
  <leader> + o          => Open a new tab
  <leader> + l          => Alternates between the last two open files in buffer
  <leader> + w          => Quickly save file (:w)
  <leader> + x          => Quickly save and exit (:wq!)
  <leader> + q          => Quickly exit (:q!)
```

#### Utils
```
  :Ack {pattern}        => Search for a pattern inside project
  :Tab /{pattern}       => Align the selected text with the choosed caracter
  <leader> + l          => Clear search highlights
  <leader> + nt         => Open/Close NerdTree
  <leader> + b          => Open/Close Method Verifier
  <leader> + be         => Open/Close Buffer Explorer
  <leader> + bt         => Open/Clone Functions panel
```

#### Other key mappings
```
  F12                   => Add/Remove line indicators, end line and alters
  :w!!                  => Save file with sudo privileges
```
