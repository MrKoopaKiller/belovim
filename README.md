# belovim
vimrc
> v2.1.1

### Prerequisites
- [Brew for Mac OSX](http://brew.sh) 
- [Git](https://git-scm.com)
- [Powerline](https://powerline.readthedocs.org/en/latest/)

### Dependencies

- python (MacOSX)
- ack-grep
- exeburant-ctags
- libjson-xs-perl
- vim-gtk (Fedora)

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
  <leader> n            => Open a new tab
  <leader> .            => Move to next tab
  <leader> ,            => Move to previous tab
  <leader> q            => Close current tab
  <leader> l            => Alternates between the last buffer
  <leader> + w          => Quickly save file (:w)
  <leader> + x          => Quickly save and exit (:wq!)
```

#### Searching
```
  :Ack {pattern}        => Search for a pattern inside project
  <leader> + h          => Hide search highlights (hlsearch!)
  <leader> + /          => Clear search highlights
```

#### Editing
```
  :Tab /{pattern}       => Align the selected text with the chose character
```

#### Utils
```
  <leader> + nt          => Open/Close NERDTree
  <leader> + b           => Open/Close Tagbar (functions panel)
  <leader> + be          => Open/Close Buffer Explorer
```

#### Functions
```
  F5     => StripTrailingWhitespaces: Remove trailing spaces in the entire text.
  F4     => DelBlank: Delete double blank lines.
  F7     => Wipeout: Destroy all buffers that are not open in any tabs or windows.
  F12    => Remove numbers and formatters
  :w!!   => Save file with sudo privileges
```
