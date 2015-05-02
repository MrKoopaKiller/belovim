" belovim by Raphael Rabelo
" github.com/rabeloo/belovim
"
if !1 | finish | endif

if has('vim_starting')
 if &compatible
   set nocompatible               " Be iMproved
 endif
   set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

call neobundle#begin(expand('~/.vim/bundle/'))
NeoBundleFetch 'Shougo/neobundle.vim'

" Manage plugin
NeoBundle 'airblade/vim-gitgutter'
NeoBundle 'bling/vim-airline'
NeoBundle 'corntrace/bufexplorer'
NeoBundle 'elzr/vim-json'
NeoBundle 'fisadev/vim-isort'
NeoBundle 'godlygeek/tabular'
NeoBundle 'kien/ctrlp.vim'
NeoBundle 'majutsushi/tagbar'
NeoBundle 'mattn/emmet-vim'
NeoBundle 'mileszs/ack.vim'
NeoBundle 'mileszs/ack.vim'
NeoBundle 'msanders/snipmate.vim'
NeoBundle 'rodjek/vim-puppet'
NeoBundle 'scrooloose/nerdcommenter'
NeoBundle 'scrooloose/nerdtree'
NeoBundle 'scrooloose/syntastic'
NeoBundle 'slim-template/vim-slim'
NeoBundle 'terryma/vim-expand-region'
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'vim-scripts/AutoComplPop'
NeoBundle 'vim-scripts/AutoTag'
NeoBundle 'vim-scripts/YankRing.vim'
NeoBundle 'vim-scripts/endwise.vim'
NeoBundle 'vim-scripts/kwbdi.vim'
NeoBundle 'vim-scripts/matchit.zip'
NeoBundle 'vim-scripts/taglist.vim'
call neobundle#end()

filetype plugin indent on      " enable file type detection

NeoBundleCheck

syntax on                      " enable syntax highlighting
filetype on                    " auto detect the type of file that is being edited
set showcmd                    " show incomplete commands
set list                       " show invisibles
set listchars=tab:▸\ ,eol:¬    " use the same symbols as TextMate for tabstops and EOLs
set number                     " show line numbers
set linebreak                  " don't break wrapped lines on words
set nowrap                     " set no word rap line
set cc=120                     " highlight N columns
set cursorcolumn               " show highlight columns on cursor
set mouse=a                    " Hablitite vim for receive mouse clicks
set clipboard=unnamedplus      " Habilite vim yank to clipboard
set backspace=indent,eol,start " intuitive backspacing
set fileformats=unix,mac,dos   " EOL format
set cursorline                 " highlight cursor line
set incsearch                  " highlight matches as you type
set hlsearch                   " highlight matches
set scrolloff=3                " show 3 lines of context around the cursor
set ignorecase smartcase       " ignore case while searching except if there's an uppercase letter
set shiftwidth=2               " number of spaces used for (auto)indent
set expandtab                  " use soft tabs (spaces)
set softtabstop=2              " size of soft tabs
set autoindent                 " auto indent lines
set smartindent                " smart (language based) auto indent
set history=100                " keep 100 cmdline history

" Enable backup and undo by default
let s:dir      = has('win32') ? '$APPDATA/Vim' : isdirectory($HOME.'/Library') ? '~/Library/Vim' : empty($XDG_DATA_HOME) ? '~/.local/share/vim' : '$XDG_DATA_HOME/vim'
let &backupdir = expand(s:dir) . '/backup//'
let &undodir   = expand(s:dir) . '/undo//'
let g:yankring_history_dir = expand(s:dir) . '/tmp//'                " YankRing temp dir
set undofile

if !isdirectory(expand(s:dir))
  call system("mkdir -p " . expand(s:dir) . "/{backup,undo,tmp}")
end

" Useful status information at bottom of screen
"set statusline=[%n]\ %<%.99f\ %h%w%m%r%y\ %{fugitive#statusline()}\ %{exists('g:loaded_rvm')?rvm#statusline():''}\ %=%-16(\ %l,%c-%v\ %)%P
set statusline=%f                                                   " tail of the filename
set statusline+=\ [%{strlen(&fenc)?&fenc:'none'},                   " file encoding
set statusline+=\ %{&ff}]                                           " file format
set statusline+=\ %r                                                " Opened type (read-only)
set statusline+=\ %m                                                " Modify?
set statusline+=\ %y                                                " File type (vim, php, ruby)
set statusline+=\ %{fugitive#statusline()}                          " Git
set statusline+=\ %{exists('g:loaded_rvm')?rvm#statusline():''}     " RVM
set statusline+=%=                                                  " left/right separator
set statusline+=%c,                                                 " cursor column
set statusline+=%l/%L                                               " cursor line/total lines
set statusline+=\ %P                                                " percent through file
set statusline+=%#warningmsg#                                       " Warning syntastic
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:airline_powerline_fonts = 1                                   " Airline
let g:airline#extensions#tabline#enabled = 1                        " Buffer line (top)
let g:airline#extensions#tabline#formatter = 'unique_tail_improved'

:noremap <C-left> :bprev<CR>                                        " Buffer Navigation
:noremap <C-right> :bnext<CR>

set wildmenu                                                        " enhanced command line completion
set wildmode=list:longest                                           " complete files like a shell
set hidden                                                          " handle multiple buffers better
colorscheme molokai                                                 " set color scheme
set t_Co=256                                                        " enable 256 colors in terminal
let mapleader="\<Space>"                                            " change leader key
nnoremap ; :                                                        " save keystrokes, so we don't need to press the Shift key
nnoremap <leader>l :e#<CR>                                          " switch to last used buffer
nnoremap <leader>y :YRShow<CR>                                      " YankRing mapping
nmap <silent> <leader>/ :nohlsearch<CR>                             " clears the search register
nmap <silent> <leader>bd <Plug>Kwbd                                 " keep window on buffer delete
nmap <silent> <leader>b :TagbarToggle<CR>                           " use tagbar
cmap w!! w !sudo tee % >/dev/null                                   " use sudo to write the file

" run the above commands only if vim is compiled with autocmd
if has("autocmd")
  autocmd BufWritePost .vimrc source $MYVIMRC " apply .vimrc settings on save
  autocmd BufWritePre *.rb,*.erb,*.html,*.js,*.css,*.php,*.py,*.json :call <SID>StripTrailingWhitespaces() " remove trailing white spaces before saving (only in specified filetypes)
endif

" function to remove trailing white space (while saving cursor position)
" http://vimcasts.org/episodes/tidying-whitespace/

function! <SID>StripTrailingWhitespaces()
  " Preparation: save last search, and cursor position.
  let _s=@/
  let l = line(".")
  let c = col(".")
  " Do the business:
  %s/\s\+$//e
  " Clean up: restore previous search history, and cursor position
  let @/=_s
  call cursor(l, c)
endfunction

" function to delete all hidden buffers
function! Wipeout()
  " list of *all* buffer numbers
  let l:buffers = range(1, bufnr('$'))

  " what tab page are we in?
  let l:currentTab = tabpagenr()
  try
    " go through all tab pages
    let l:tab = 0
    while l:tab < tabpagenr('$')
      let l:tab += 1

      " go through all windows
      let l:win = 0
      while l:win < winnr('$')
        let l:win += 1
        " whatever buffer is in this window in this tab, remove it from
        " l:buffers list
        let l:thisbuf = winbufnr(l:win)
        call remove(l:buffers, index(l:buffers, l:thisbuf))
      endwhile
    endwhile

    " if there are any buffers left, delete them
    if len(l:buffers)
      execute 'bwipeout' join(l:buffers)
    endif
  finally
    " go back to our original tab page
    execute 'tabnext' l:currentTab
  endtry
endfunction

map <leader>bw :call Wipeout()<CR>                        " mapping for function above
map <leader>nt :NERDTreeToggle<CR>                        " NerdTree
map <leader>jt <Esc>:%!json_xs -f json -t json-pretty<CR> " JSON Format
nnoremap <C-w>k :tabnew %<CR>                             " Tab next
nnoremap <C-w>l :tabprevious<CR>
nnoremap <C-w>h :tabnext<CR>
nnoremap <leader>p :CtrlP<CR>                             " List all files with a patern
nnoremap <leader>P :CtrlPBuffer<CR>                       " List all files with a patern in buffer
nnoremap <leader>l :e#<CR>                                " switch to last used buffer
nnoremap <leader>y :YRShow<CR>                            " YankRing mapping
map <leader>T :TlistToggle<CR>                            " TagList of functions

let g:syntastic_error_symbol='✗' " Enable syntastic syntax checking
let g:syntastic_warning_symbol='⚠'
let g:syntastic_enable_signs=1
let g:syntastic_check_on_open=1
let g:syntastic_auto_jump=1
let g:syntastic_enable_highlighting=1

" Defines specific files extensions for highlighting
if has("syntax")
  au BufNewFile,BufRead *.jsonify set filetype=ruby
endif

" Toggle for add and remove line number, end line, and changes indicators
" Good for copy multilines from vim (for example)
imap <F12> <c-o>:set list! \| set nu! \| call gitgutter#toggle()<CR>
map <F12> :set list! \| set nu! \| call gitgutter#toggle()<CR>

vmap v <Plug>(expand_region_expand)     " vim-expand-region: Expand selection
vmap <C-v> <Plug>(expand_region_shrink) " vim-expand-region: Restore previous slection
