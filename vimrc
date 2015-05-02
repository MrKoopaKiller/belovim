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

syntax on                                                            " enable syntax highlighting
filetype on                                                          " enable
filetype plugin on                                                   " enable file type detection
filetype indent on                                                   " enable filetype-based indentation

NeoBundleCheck

let mapleader="\<Space>"                                             " change leader key
colorscheme molokai                                                  " set color scheme

set clipboard=unnamedplus                                            " enable YankRing to clipboard
set laststatus=2                                                     " always show status bat
set history=1000                                                     " size of history
set showcmd                                                          " show incomplete commands
set list                                                             " show invisibles
set listchars=tab:▸\ ,eol:¬                                          " use the same symbols as TextMate for tabstops and EOLs
set number                                                           " show line numbers
set linebreak                                                        " don't break wrapped lines on words
set nowrap                                                           " set no word rap line
set cc=120                                                           " highlight N columns
set cursorcolumn                                                     " show highlight columns on cursor
set mouse=a                                                          " enable vim mouse detection
set backspace=indent,eol,start                                       " intuitive backspacing
set fileformats=unix,mac,dos                                         " EOL format
set cursorline                                                       " highlight cursor line
set incsearch                                                        " highlight matches as you type
set hlsearch                                                         " highlight matches
set scrolloff=3                                                      " show 3 lines of context around the cursor
set ignorecase smartcase                                             " ignore case while searching except if there's an uppercase letter
set shiftwidth=2                                                     " indent: number of spaces used for (auto)indent
set expandtab                                                        " indent: use soft tabs (spaces)
set softtabstop=2                                                    " indent: size of soft tabs
set autoindent                                                       " indent: auto indent lines
set smartindent                                                      " indent: smart (language based) auto indent
set statusline=%f                                                    " statusbar: tail of the filename
set statusline+=\ [%{strlen(&fenc)?&fenc:'none'},                    " statusbar: file encoding
set statusline+=\ %{&ff}]                                            " statusbar: file format
set statusline+=\ %r                                                 " statusbar: Opened type (read-only)
set statusline+=\ %m                                                 " statusbar: Modify?
set statusline+=\ %y                                                 " statusbar: File type (vim, php, ruby)
set statusline+=\ %{fugitive#statusline()}                           " statusbar: Git
set statusline+=\ %{exists('g:loaded_rvm')?rvm#statusline():''}      " statusbar: RVM
set statusline+=%=                                                   " statusbar: left/right separator
set statusline+=%c,                                                  " statusbar: cursor column
set statusline+=%l/%L                                                " statusbar: cursor line/total lines
set statusline+=\ %P                                                 " statusbar: percent through file
set statusline+=%#warningmsg#                                        " syntastic warning
set statusline+=%{SyntasticStatuslineFlag()}                         " syntastic warning
set statusline+=%*                                                   " syntastic warning

map <F12> :set list! \| set nu! \| call gitgutter#toggle()<CR>       " hidden line number, end line and changes indicators
imap <F12> <c-o>:set list! \| set nu! \| call gitgutter#toggle()<CR> " hidden line number, end line and changes indicators
map <leader>T :TlistToggle<CR>                                       " TagList of functions
nmap <leader><leader> V                                              " Enter in VISUAL mode
vmap v <Plug>(expand_region_expand)                                  " vim-expand-region: Expand selection
vmap <C-v> <Plug>(expand_region_shrink)                              " vim-expand-region: Restore previous slection

nnoremap <CR> G                                                      " go to end of file <ENTER>
nnoremap <BS> gg                                                     " go to the beginning of file <BACKSPACE>
nnoremap <silent> <C-L> :nohlsearch<CR><C-L>                         " clear text highlighted
nnoremap <leader>y :YRShow<CR>                                       " YankRing key
nnoremap <leader>w :w<CR>                                            " quickly save file
nnoremap <leader>x :x<CR>                                            " quickly exit without save
nnoremap <leader>p :CtrlP<CR>                                        " CtrlP: List all files with a patern
nnoremap <leader>P :CtrlPBuffer<CR>                                  " CtrlP: List all files with a patern in buffer
nnoremap <leader>l :e#<CR>                                           " switch to last used buffer
nnoremap <leader>y :YRShow<CR>                                       " YankRing mapping

let g:syntastic_error_symbol        = '✗'                            " Enable syntastic syntax checking
let g:syntastic_warning_symbol      = '⚠'                            " Enable syntastic syntax checking
let g:syntastic_enable_signs        = 1                              " Enable syntastic syntax checking
let g:syntastic_check_on_open       = 1                              " Enable syntastic syntax checking
let g:syntastic_auto_jump           = 1                              " Enable syntastic syntax checking
let g:syntastic_enable_highlighting = 1                              " Enable syntastic syntax checking

" Enable backup and undo by default
let s:dir      = has('win32') ? '$APPDATA/Vim' : isdirectory($HOME.'/Library') ? '~/Library/Vim' : empty($XDG_DATA_HOME) ? '~/.local/share/vim' : '$XDG_DATA_HOME/vim'
let &backupdir = expand(s:dir) . '/backup//'
let &undodir   = expand(s:dir) . '/undo//'
let g:yankring_history_dir = expand(s:dir) . '/tmp//'                " YankRing temp dir
set undofile

if !isdirectory(expand(s:dir))
  call system("mkdir -p " . expand(s:dir) . "/{backup,undo,tmp}")
end

" Tabularize maps
if exists(":Tabularize")
  nmap <leader>a= :Tabularize /=<CR>
  vmap <leader>a= :Tabularize /=<CR>
  nmap <leader>z: :Tabularize /:\zs<CR>
  vmap <leader>z: :Tabularize /:\zs<CR>
endif

" Warnings quiet
let g:syntastic_quiet_messages = {'level': 'warnings'}
 run the above commands only if vim is compiled with autocmd

if has("autocmd")
  autocmd BufWritePost .vimrc source $MYVIMRC " apply .vimrc settings on save
  autocmd BufWritePre *.rb,*.erb,*.html,*.js,*.css,*.php,*.py,*.json :call <SID>StripTrailingWhitespaces() " remove trailing white spaces before saving (only in specified filetypes)
endif

" function to remove trailing white space (while saving cursor position)
" http://vimcasts.org/episodes/tidying-whitespace/

function! <SID>StripTrailingWhitespaces()
 Preparation: save last search, and cursor position.
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

map <leader>bw :call Wipeout()<CR>  " mapping for function above


" Defines specific files extensions for highlighting
if has("syntax")
  au BufNewFile,BufRead *.jsonify set filetype=ruby
endif
