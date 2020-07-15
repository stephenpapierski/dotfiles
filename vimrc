" Maintainer:	Stephen Papierski <stephenpapierski@gmail.com>
" Last change:	2020 July 15


"*****************************************************************************
"" Vim-PLug core
"*****************************************************************************
let vimplug_exists=expand('~/.vim/autoload/plug.vim')

if !filereadable(vimplug_exists)
  if !executable("curl")
    echoerr "You have to install curl or first install vim-plug yourself!"
    execute "q!"
  endif
  echo "Installing Vim-Plug..."
  echo ""
  silent exec "!\curl -fLo " . vimplug_exists . " --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"
  let g:not_finish_vimplug = "yes"

  autocmd VimEnter * PlugInstall
endif

" Required:
call plug#begin(expand('~/.vim/plugged'))

"*****************************************************************************
"" Plug install packages
"*****************************************************************************
call plug#begin(expand('~/.vim/plugged'))

Plug 'preservim/nerdtree'
" Plug 'sonph/onehalf', {'rtp': 'vim/'}
Plug 'rakr/vim-one'
Plug 'itchyny/lightline.vim'
Plug 'mengelbrecht/lightline-bufferline'
Plug 'tpope/vim-commentary'
Plug 'jiangmiao/auto-pairs'
Plug 'Yggdroot/indentLine'
Plug 'mmozuras/vim-whitespace'
" Plug 'ajh17/VimCompletesMe'
"
"
" Great colorscheme but overrides lightline colorscheme
" Plug 'morhetz/gruvbox'
"
"Plug 'mhinz/vim-sayonara', { 'on': 'Sayonara' }
"Plug 'mkitt/tabline.vim'
"Plug 'jistr/vim-nerdtree-tabs'
"Plug 'tpope/vim-fugitive'
"Plug 'airblade/vim-gitgutter'
"Plug 'vim-scripts/grep.vim'
"Plug 'vim-scripts/CSApprox'
"Plug 'Raimondi/delimitMate'
"Plug 'majutsushi/tagbar'
"Plug 'w0rp/ale'
"Plug 'sheerun/vim-polyglot'
"Plug 'tpope/vim-rhubarb' " required by fugitive to :Gbrowse

if isdirectory('/usr/local/opt/fzf')
  Plug '/usr/local/opt/fzf' | Plug 'junegunn/fzf.vim'
else
  Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --bin' }
  Plug 'junegunn/fzf.vim'
endif

call plug#end()


"*****************************************************************************
"" Basic setup
"*****************************************************************************
" Makes Vim work without being Vi-compatible, making it all its enhancements/improvements/features available
" This must be first, because it changes other options as a side effect.
set nocompatible

" Ignore a file's modelines (comments in a file that override vim settings)
set nomodeline

" Allow backspacing over everything in insert mode
set backspace=indent,eol,start
"
" If you need mouse support, enable it
"if has('mouse')
"  set mouse=a
"endif
"
" Keep 50 lines of command line history
set history=50

"" Code Formatting
set autoindent          " auto indent
filetype plugin indent on
set expandtab           " expand tabs into spaces
set tabstop=4           " tab width is 4 spaces
set shiftwidth=4
set softtabstop=4       " backspace will remove entire 'tab' instead of just one space

"" Visual Layout
set number              " Show line numbers
"set cursorline         " Put a line under the currently selected line
set ruler		        " show the cursor position all the time
set showcmd		        " display incomplete commands
set laststatus=2        " shows statusbar at all times
set noshowmode          " dont display mode (lightline handles this)

"" Color Settings
colorscheme one
" autocmd vimenter * colorscheme gruvbox
set background=dark     " Enable dark mode
syntax on               " Turn on syntax highlighting.

"" Searching
set hlsearch            " Highlight matching search patterns
set incsearch           " Enable incremental search (starts highlighting before you hit enter)
"set ignorecase         " Case insentitive search (this includes replacements)
"set smartcase          " Case sensitive search if search contains capital letter

"" Split Settings
set splitbelow          " Open new vertical split panes to the right
set splitright          " Open new horizontal split panes below

" indentLine options
let g:indentLine_char = '¦'
let g:indentLine_leadingSpaceEnabled = 1
let g:indentLine_leadingSpaceChar = '.'

"" Lightline Options
" Add tab bar
let g:lightline = {
      \ 'colorscheme': 'one',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ], [ 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'tabline': {
      \   'left': [ ['buffers'] ],
      \   'right': [ [''] ]
      \ },
      \ 'component_expand': {
      \   'buffers': 'lightline#bufferline#buffers'
      \ },
      \ 'component_type': {
      \   'buffers': 'tabsel'
      \ }
      \ }
let g:lightline#bufferline#filename_modifier = ':t'
let g:lightline#bufferline#show_number = 1  " Show buffer number on tabline (switch with :bx where x is buffer number)
let g:lightline#bufferline#clickable = 0    " Disable clickable tabs
set showtabline=2                           " Always show tabline



" Consider these options
"
" Set format options
" set formatoptions=tcqrn1
" Wrap text that extends beyond the screen length.
" set wrap
" Wrap text that extends past 80 characters
" textwidth = 80


"*****************************************************************************
"" Key mappings
"*****************************************************************************
"" Vim Native
nnoremap <C-j> <C-w>j   " Ctrl-j = Move down to the next split pane
nnoremap <C-k> <C-w>k   " Ctrl-k = Move up to the next split pane
nnoremap <C-h> <C-w>h   " Ctrl-h = Move left to the next split pane
nnoremap <C-l> <C-w>l   " Ctrl-l = Move right to the next split pane
"" NERDTree
nmap <silent> <F2> :execute 'NERDTreeToggle ' . getcwd()<CR>    " Toggle the NERDTree explorer

"" FZF
map <C-t> <Esc><Esc>:Files!<CR>         " Ctrl-t = Fuzzy find a file starting from the current directory
map <C-f> <Esc><Esc>:BLines!<CR>        " Ctrl-f = Fuzy find text within the file
" Put the following in your .bashrc to define what FzF uses to find files
" (ignores hidden files, build files in /iso/ and /build/)
"export FZF_DEFAULT_COMMAND="find . -type f \( ! -iname '.*' \) | grep -v '/iso/' | grep -v '/build/' | grep -v '.svn'"

"" Sayonara
"nnoremap <silent> <leader>q :Sayonara!<CR>   " q = Smart close of just the current buffer
"nnoremap <space>q :Sayonara!<cr>



"*****************************************************************************
"" Vim Cheatsheet
"*****************************************************************************
"" FZF
" Ctrl-t        Search a file
"   Enter           Open file in current window
"   Ctrl-x          Open file in new split
"   Ctrl-v          Open file in new vertical split
" Ctrl -f       Search for a line in the current buffer









"
"set ruler		" show the cursor position all the time
"set showcmd		" display incomplete commands
"
"" Don't use Ex mode, use Q for formatting
"map Q gq
"
"" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
"" so that you can undo CTRL-U after inserting a line break.
"inoremap <C-U> <C-G>u<C-U>
"
"" In many terminal emulators the mouse works just fine, thus enable it.
"if has('mouse')
"  set mouse=a
"endif
"
"" Only do this part when compiled with support for autocommands.
"if has("autocmd")
"
"  " Enable file type detection.
"  " Use the default filetype settings, so that mail gets 'tw' set to 72,
"  " 'cindent' is on in C files, etc.
"  " Also load indent files, to automatically do language-dependent indenting.
"  filetype plugin indent on
"
"  " Put these in an autocmd group, so that we can delete them easily.
"  augroup vimrcEx
"  au!
"
"  " For all text files set 'textwidth' to 78 characters.
"  autocmd FileType text setlocal textwidth=78
"
"  " When editing a file, always jump to the last known cursor position.
"  " Don't do it when the position is invalid or when inside an event handler
"  " (happens when dropping a file on gvim).
"  " Also don't do it when the mark is in the first line, that is the default
"  " position when opening a file.
"  autocmd BufReadPost *
"    \ if line("'\"") > 1 && line("'\"") <= line("$") |
"    \   exe "normal! g`\"" |
"    \ endif
"
"  augroup END
"
"else
"
"  set autoindent		" always set autoindenting on
"
"endif " has("autocmd")
"
"" Convenient command to see the difference between the current buffer and the
"" file it was loaded from, thus the changes you made.
"" Only define it when not defined already.
"if !exists(":DiffOrig")
"  command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
"		  \ | wincmd p | diffthis
"endif
"imap {} {<cr>}<esc>O
"set ls=2    "shows file name at all times
"
"" Changes terminal title to open file name
"autocmd BufEnter * let &titlestring = expand("%:@")
"set title
"let &titleold='Terminal'
"" end change terminal title
"
"
"" Highlights characters that go over the prefered character line length
"augroup vimrc_autocmds
"    autocmd BufEnter * highlight OverLength ctermbg=darkred guibg=#FFD9D9
"    autocmd BufEnter * match OverLength /\%>80v.\+/
"augroup END
"
