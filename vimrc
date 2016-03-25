" belovim by Raphael Rabelo
" github.com/rabeloo/belovim
"
if !1 | finish | endif

if has('vim_starting')
 if &compatible
   set nocompatible
 endif
   set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

call neobundle#begin(expand('~/.vim/bundle/'))
NeoBundleFetch 'Shougo/neobundle.vim'

" Plugins Manager
NeoBundle 'airblade/vim-gitgutter'
NeoBundle 'bling/vim-airline'
NeoBundle 'corntrace/bufexplorer'
NeoBundle 'godlygeek/tabular'
NeoBundle 'scrooloose/nerdcommenter'
NeoBundle 'scrooloose/nerdtree'
NeoBundle 'scrooloose/syntastic'
NeoBundle 'sheerun/vim-polyglot'
NeoBundle 'slim-template/vim-slim'
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'tpope/vim-surround'
NeoBundle 'vim-scripts/AutoComplPop'
NeoBundle 'vim-scripts/AutoTag'
NeoBundle 'raimondi/delimitmate'
NeoBundle 'tpope/vim-abolish'
NeoBundle 'tpope/vim-repeat'
call neobundle#end()
filetype plugin indent on

NeoBundleCheck

syntax on
filetype on
set showcmd
set hidden
set list
set listchars=tab:>-,trail:.,precedes:<,extends:>
set number
set linebreak
set nowrap
set cc=80
set cursorcolumn
set mouse=a
set clipboard=unnamed
set backspace=indent,eol,start
set fileformats=unix,mac,dos
set cursorline
set incsearch
set hlsearch
set scrolloff=3
set ignorecase smartcase
set shiftwidth=2
set expandtab
set softtabstop=2
set autoindent
set smartindent
set history=100
set laststatus=2

" Command line completion
set wildmenu
set wildmode=longest:full,full

" Set color scheme
colorscheme molokai

" Use 256 colors
set t_Co=256

" Mapping the leader key
let mapleader="\<Space>"

" Enable backup and undo by default
let s:dir      = has('win32') ? '$APPDATA/Vim' : isdirectory($HOME.'/Library') ? '~/Library/Vim' : empty($XDG_DATA_HOME) ? '~/.local/share/vim' : '$XDG_DATA_HOME/vim'
let &backupdir = expand(s:dir) . '/backup//'
let &undodir   = expand(s:dir) . '/undo//'
set undofile

if !isdirectory(expand(s:dir))
  call system("mkdir -p " . expand(s:dir) . "/{backup,undo,tmp}")
end

" [EVALUATE] Statusline configs
set statusline=%f
set statusline+=\ [%{strlen(&fenc)?&fenc:'none'},
set statusline+=\ %{&ff}]
set statusline+=\ %r
set statusline+=\ %m
set statusline+=\ %y
set statusline+=\ %{fugitive#statusline()}
set statusline+=\ %{exists('g:loaded_rvm')?rvm#statusline():''}
set statusline+=%=
set statusline+=%c,
set statusline+=%l/%L
set statusline+=\ %P
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

"Airline configs
let g:airline_powerline_fonts = 0
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#formatter = 'unique_tail_improved'

" Syntastic configs
let g:syntastic_error_symbol='EE'
let g:syntastic_warning_symbol='WW'
let g:syntastic_enable_signs=1
let g:syntastic_check_on_open=1
let g:syntastic_auto_jump=1
let g:syntastic_enable_highlighting=1
let g:gitgutter_max_signs = 3000

nnoremap ; :

" Enable folding
set foldmethod=syntax
set foldlevelstart=2

let javaScript_fold=1         " JavaScript
let perl_fold=1               " Perl
let php_folding=1             " PHP
let r_syntax_folding=1        " R
let ruby_fold=1               " Ruby
let sh_fold_enabled=1         " sh
let vimsyn_folding='af'       " Vim script
let xml_syntax_folding=1      " XML

" Alternates to last file
nnoremap <leader>l :e#<CR>

" NERDTree plugin map key
map <leader>nt :NERDTreeToggle<CR>

" Save as root user
cmap w!! w !sudo tee % >/dev/null

" Remove numbers and formatter
imap <F12> <c-o>:set list! \| set nu! \| call gitgutter#toggle()<CR>
map <F12> :set list! \| set nu! \| call gitgutter#toggle()<CR>

" Removing tidying spaces
" run the above commands only if vim is compiled with autocmd
" http://vimcasts.org/episodes/tidying-whitespace/

if has("autocmd")
  autocmd BufWritePost .vimrc source $MYVIMRC
  autocmd BufWritePre *.pp,*.rb,*.erb,*.html,*.js,*.css,*.php,*.py,*.json :call <SID>StripTrailingWhitespaces()
endif

" StripTrailingWhitespaces: Remove traling spaces in the entire text.
function! <SID>StripTrailingWhitespaces()
  let _s=@/
  let l = line(".")
  let c = col(".")
  %s/\s\+$//e
  let @/=_s
  call cursor(l, c)
endfunction

" Wipeout: Destroy all buffers that are not open in any tabs or windows.
function! <SID>Wipeout()
  let l:buffers = range(1, bufnr('$'))
  let l:currentTab = tabpagenr()
  try
    let l:tab = 0
    while l:tab < tabpagenr('$')
      let l:tab += 1

      let l:win = 0
      while l:win < winnr('$')
        let l:win += 1
        " l:buffers list
        let l:thisbuf = winbufnr(l:win)
        call remove(l:buffers, index(l:buffers, l:thisbuf))
      endwhile
    endwhile

    if len(l:buffers)
      execute 'bwipeout' join(l:buffers)
    endif
  finally
    execute 'tabnext' l:currentTab
  endtry
endfunction

" DelBlank: Delete blank lines in the entire text.
function! <SID>DelBlank()
   let _s=@/
   let l = line(".")
   let c = col(".")
   :g/^\n\{2,}/d
   let @/=_s
   call cursor(l, c)
endfun

" Call function Delblank
nnoremap <silent> <F4> :call <SID>DelBlank()<CR>

" Call function StripTrailingWhitespaces
nnoremap <silent> <F5> :call <SID>StripTrailingWhitespaces()<CR>

" Call function Delblank
nnoremap <silent> <F7> :call <SID>Wipeout()<CR>

" Coping/paste to system clipboard. (Note: '+clipboard' must be enabled)
vmap <Leader>y "+y
vmap <Leader>d "+d
vmap <Leader>p "+p
vmap <Leader>P "+P
nmap <Leader>p "+p
nmap <Leader>P "+P

" Go to end of file
nnoremap <CR> G

" Go to beginning of file
nnoremap <BS> gg

" Save and exit
nnoremap <leader>x :x!<CR>

" Save file
nnoremap <leader>w :w<CR>

" Quit file without save
"nnoremap <leader>q :q!<CR>

" Managing tabs
nmap <silent> <leader>q <Plug>Kwbd
:noremap <leader>, :bprev<CR>
:noremap <leader>. :bnext<CR>
noremap <leader>n :tabnew<CR>

" Hide search highlights
nnoremap <leader>h :set hlsearch!<CR>

" Clean search highlight
nmap <silent> <leader>/ :nohlsearch<CR>

autocmd VimEnter * echo "[+] Welcome to belovim!"
