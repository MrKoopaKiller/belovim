" do not use vi compatibility mode. must come first because it changes other options.
set nocompatible

" show incomplete commands
set showcmd

" show invisibles
set list

" use the same symbols as TextMate for tabstops and EOLs
set listchars=tab:▸\ ,eol:¬

" show line numbers
set number

" don't break wrapped lines on words
set linebreak

" set no word rap line
set nowrap

" highlight N columns
set cc=120

" show highlight columns on cursor
set cursorcolumn

" Hablitite vim for receive mouse clicks
set mouse=a

" Habilite vim yank to clipboard
set clipboard=unnamedplus

" enable syntax highlighting
syntax on

call pathogen#infect()
call pathogen#helptags()

" auto detect the type of file that is being edited 
filetype on
" enable file type detection
filetype plugin on
" enable filetype-based indentation
filetype indent on

" intuitive backspacing
set backspace=indent,eol,start

" EOL format
set fileformats=unix,mac,dos

" highlight cursor line
set cursorline

" highlight matches as you type
set incsearch 

" highlight matches
set hlsearch

" show 3 lines of context around the cursor
set scrolloff=3

" ignore case while searching except if there's an uppercase letter
set ignorecase smartcase

" indent settings
set shiftwidth=2 " number of spaces used for (auto)indent
set expandtab " use soft tabs (spaces)
set softtabstop=2 " size of soft tabs
set autoindent " auto indent lines
set smartindent " smart (language based) auto indent 

" keep 100 cmdline history
set history=100

" persistent undo
set undofile
set undodir=~/.vim/tmp

" backup options
set backup " turn on backup
set backupdir=~/.vim/backup " dir to save backup files
set directory=~/.vim/tmp " dir to keep all swap files

" show status line all the time
set laststatus=2

" Useful status information at bottom of screen
"set statusline=[%n]\ %<%.99f\ %h%w%m%r%y\ %{fugitive#statusline()}\ %{exists('g:loaded_rvm')?rvm#statusline():''}\ %=%-16(\ %l,%c-%v\ %)%P
"statusline setup
set statusline=%f                                               " tail of the filename
set statusline+=\ [%{strlen(&fenc)?&fenc:'none'},               " file encoding
set statusline+=\ %{&ff}]                                       " file format
set statusline+=\ %r                                            " Opened type (read-only)
set statusline+=\ %m                                            " Modify?
set statusline+=\ %y                                            " File type (vim, php, ruby)
set statusline+=\ %{fugitive#statusline()}                      " Git
set statusline+=\ %{exists('g:loaded_rvm')?rvm#statusline():''} " RVM
set statusline+=%=                                              " left/right separator
set statusline+=%c,                                             " cursor column
set statusline+=%l/%L                                           " cursor line/total lines
set statusline+=\ %P                                            " percent through file
 
" Warning syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

" Airline
"  Fonts
let g:airline_powerline_fonts = 1
"  Buffer line (top)
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#formatter = 'unique_tail_improved'

" Buffer Navigation
:noremap <C-left> :bprev<CR>
:noremap <C-right> :bnext<CR> 

" enhanced command line completion
set wildmenu
" complete files like a shell
set wildmode=list:longest

" handle multiple buffers better
set hidden

" set color scheme
colorscheme Tomorrow-Night

" enable 256 colors in terminal
set t_Co=256

" change leader key
let mapleader=","

" save keystrokes, so we don't need to press the Shift key
nnoremap ; :

" switch to last used buffer
nnoremap <leader>l :e#<CR>

" YankRing mapping
nnoremap <leader>y :YRShow<CR>

" YankRing configs
let g:yankring_history_dir = "~/.vim/tmp"

" clears the search register
nmap <silent> <leader>/ :nohlsearch<CR>

" keep window on buffer delete
nmap <silent> <leader>bd <Plug>Kwbd

" use tagbar
nmap <silent> <leader>b :TagbarToggle<CR>

" use sudo to write the file
cmap w!! w !sudo tee % >/dev/null

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

" mapping for function above
map <leader>bw :call Wipeout()<CR>

" NerdTree
map <leader>nt :NERDTreeToggle<CR>

" JSON Format
map <leader>jt <Esc>:%!json_xs -f json -t json-pretty<CR>

" Tab next
nnoremap <C-w>k :tabnew %<CR>
nnoremap <C-w>l :tabprevious<CR>
nnoremap <C-w>h :tabnext<CR>

" Ctrlp
" List all files with a patern
nnoremap <leader>p :CtrlP<CR>

" List all files with a patern in buffer
nnoremap <leader>P :CtrlPBuffer<CR>

" switch to last used buffer
nnoremap <leader>l :e#<CR>

" YankRing mapping
nnoremap <leader>y :YRShow<CR>

" TagList of functions
map <leader>T :TlistToggle<CR>

" Enable syntastic syntax checking
let g:syntastic_error_symbol='✗'
let g:syntastic_warning_symbol='⚠'
let g:syntastic_enable_signs=1
let g:syntastic_check_on_open=1
let g:syntastic_auto_jump=1
let g:syntastic_enable_highlighting=1

" Warnings quiet
"let g:syntastic_quiet_warnings=1

" Defines specific files extensions for highlighting
if has("syntax")
  au BufNewFile,BufRead *.jsonify set filetype=ruby
endif

" Ruby debugger
map <leader>rdb orequire 'pry'; binding.pry<ESC>:w<CR>

" Toggle for add and remove line number, end line, and changes indicators
" Good for copy multilines from vim (for example)
imap <F12> <c-o>:set list! \| set nu! \| call gitgutter#toggle()<CR>
map <F12> :set list! \| set nu! \| call gitgutter#toggle()<CR>
