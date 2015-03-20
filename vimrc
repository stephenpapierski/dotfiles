
" An example for a vimrc file.
"
" Maintainer:	Bram Moolenaar <Bram@vim.org>
" Last change:	2008 Dec 17
"
" To use it, copy it to
"     for Unix and OS/2:  ~/.vimrc
"	      for Amiga:  s:.vimrc
"  for MS-DOS and Win32:  $VIM\_vimrc
"	    for OpenVMS:  sys$login:.vimrc

" When started as "evim", evim.vim will already have done these settings.
if v:progname =~? "evim"
  finish
endif

" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

set history=50		" keep 50 lines of command line history
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
set incsearch		" do incremental searching

" For Win32 GUI: remove 't' flag from 'guioptions': no tearoff menu entries
" let &guioptions = substitute(&guioptions, "t", "", "g")

" Don't use Ex mode, use Q for formatting
map Q gq

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
  set mouse=a
endif

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  " Also don't do it when the mark is in the first line, that is the default
  " position when opening a file.
  autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

  augroup END

else

  set autoindent		" always set autoindenting on

endif " has("autocmd")

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
		  \ | wincmd p | diffthis
endif
set expandtab
set shiftwidth=4
set tabstop=4
set number
imap {} {<cr>}<esc>O
set ls=2    "shows file name at all times

" Changes terminal title to open file name
autocmd BufEnter * let &titlestring = expand("%:@")
set title
let &titleold='Terminal'
" end change terminal title

" Apply custom header to files
"   define templates
autocmd bufnewfile *.c,*.cpp so ~/.c_header
autocmd bufnewfile *.h so ~/.h_header

"   custom commands per file
let hdefine = toupper(expand("%"))
autocmd bufnewfile *.h silent exe "1," . line("$") . "g/H_H.*/s//" .hdefine
"execute 'autocmd bufnewfile *.h exe "1," . 13 . "g/H_H.*/s//" .hdefine'
autocmd bufnewfile *.h silent exe "1," . line("$") . "g/.H.*/s//_H"

let all_files = "*.c,*.cpp,*.h"
"   commands on all files
execute 'autocmd bufnewfile '.all_files.' exe "1," . 6 . "g/file.*/s//file    " .expand("%")'
execute 'autocmd bufnewfile '.all_files.' exe "1," . 6 . "g/date.*/s//date    " .strftime("%Y-%m-%e %T")'
execute 'autocmd Bufwritepre,filewritepre '.all_files.' execute "normal ma"'
execute 'autocmd Bufwritepre,filewritepre '.all_files.' exe "1," . 6 . "g/edited.*/s/edited.*/edited  " .strftime("%Y-%m-%e %T")'
execute 'autocmd bufwritepost,filewritepost '.all_files.' execute "normal `a"'

"   custom post commands per file
        "goes to line 12
autocmd bufnewfile *.h execute "normal! 12gg"
        "goes to line 10
autocmd bufnewfile *.c,*.cpp execute "normal! 10gg"
" end custom header
