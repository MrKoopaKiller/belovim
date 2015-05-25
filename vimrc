" belovim by Raphael Rabelo
" github.com/rabeloo/belovim
"
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

" Manage plugin
NeoBundle 'airblade/vim-gitgutter'
NeoBundle 'bling/vim-airline'
NeoBundle 'corntrace/bufexplorer'
NeoBundle 'elzr/vim-json'
NeoBundle 'godlygeek/tabular'
NeoBundle 'majutsushi/tagbar'
NeoBundle 'mattn/emmet-vim'
NeoBundle 'mileszs/ack.vim'
NeoBundle 'mileszs/ack.vim'
NeoBundle 'msanders/snipmate.vim'
NeoBundle 'rodjek/vim-puppet'
NeoBundle 'scrooloose/nerdcommenter'
NeoBundle 'scrooloose/nerdtree'
NeoBundle 'scrooloose/syntastic'
NeoBundle 'sheerun/vim-polyglot'
NeoBundle 'slim-template/vim-slim'
NeoBundle 'terryma/vim-expand-region'
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'tpope/vim-surround'
NeoBundle 'vim-scripts/AutoComplPop'
NeoBundle 'vim-scripts/AutoTag'
NeoBundle 'vim-scripts/YankRing.vim'
NeoBundle 'vim-scripts/endwise.vim'
NeoBundle 'vim-scripts/kwbdi.vim'
NeoBundle 'vim-scripts/matchit.zip'
NeoBundle 'vim-scripts/taglist.vim'
call neobundle#end()

filetype plugin indent on

NeoBundleCheck

syntax on
filetype on
set showcmd
set list
set listchars=tab:▸\ ,eol:¬
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

let g:airline_powerline_fonts=1
let g:airline#extensions#tabline#enabled=1
let g:airline#extensions#tabline#formatter='unique_tail_improved'

set wildmenu
set wildmode=list:longest
set hidden
colorscheme molokai
set t_Co=256
let mapleader="\<Space>"
nnoremap ; :
nnoremap <leader>l :e#<CR>
nnoremap <leader>y :YRShow<CR>
nmap <silent> <leader>/ :nohlsearch<CR>
nmap <silent> <leader>bd <Plug>Kwbd
nmap <silent> <leader>b :TagbarToggle<CR>
cmap w!! w !sudo tee % >/dev/null

" run the above commands only if vim is compiled with autocmd
if has("autocmd")
  autocmd BufWritePost .vimrc source $MYVIMRC
  autocmd BufWritePre *.rb,*.erb,*.html,*.js,*.css,*.php,*.py,*.json :call <SID>StripTrailingWhitespaces()
endif

" function to remove trailing white space (while saving cursor position)
" http://vimcasts.org/episodes/tidying-whitespace/

function! <SID>StripTrailingWhitespaces()
  let _s=@/
  let l = line(".")
  let c = col(".")
  %s/\s\+$//e
  let @/=_s
  call cursor(l, c)
endfunction

function! Wipeout()
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

map <leader>bw :call Wipeout()<CR>
map <leader>nt :NERDTreeToggle<CR>
map <leader>jt <Esc>:%!json_xs -f json -t json-pretty<CR>
map <leader>T :TlistToggle<CR>

let g:syntastic_error_symbol='✗'
let g:syntastic_warning_symbol='⚠'
let g:syntastic_enable_signs=1
let g:syntastic_check_on_open=1
let g:syntastic_auto_jump=1
let g:syntastic_enable_highlighting=1

if has("syntax")
  au BufNewFile,BufRead *.jsonify set filetype=ruby
endif

imap <F12> <c-o>:set list! \| set nu! \| call gitgutter#toggle()<CR>
map <F12> :set list! \| set nu! \| call gitgutter#toggle()<CR>

vmap v <Plug>(expand_region_expand)
vmap <C-v> <Plug>(expand_region_shrink)

nnoremap <leader>l :e#<CR>
nnoremap <leader>y :YRShow<CR>

nnoremap <CR> G
nnoremap <BS> gg
nnoremap <leader>x :x!<CR>
nnoremap <leader>w :w<CR>
nnoremap <leader>q :q!<CR>

:noremap <leader>> :bprev<CR>
:noremap <leader>< :bnext<CR>
noremap <leader>o :tabnew<CR>
nnoremap <leader>l :set hlsearch!<CR>

vmap <Leader>y "+y
vmap <Leader>d "+d
vmap <Leader>p "+p
vmap <Leader>P "+P
nmap <Leader>p "+p
nmap <Leader>P "+P
