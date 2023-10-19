syntax enable

let g:codedark_modern=1
" Activates italicized comments (make sure your terminal supports italics)
let g:codedark_italics=1

colo codedark 

highlight Normal ctermbg=black
highlight LineNr ctermfg=darkgrey ctermbg=black
highlight EndOfBuffer ctermbg=black

set autoindent
set autoread
set hlsearch "when there is a previous search pattern, highlight all its matches
set ignorecase "ignore case in search patterns
set incsearch "while typing a search command, show immediately where the so far typed pattern matches
set nocompatible
set number
set ofu=syntaxcomplete#Complete
set smartcase "override the 'ignorecase' option if the search pattern contains uppercase characters
set smartindent
set smarttab
set relativenumber
set t_Co=256
set ttyfast

let mapleader = "\<space>"
nnoremap <leader>pv :Ex<CR> 

" move selections with Shift+J and Shift+K
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

nnoremap Q <nop>
nnoremap <Up> <nop>
nnoremap <Down> <nop>
nnoremap <Left> <nop>
nnoremap <Right> <nop>

inoremap <Up> <nop>
inoremap <Down> <nop>
inoremap <Left> <Nop>
inoremap <Right> <nop>

" save file with leader w
nnoremap  <leader>w :w<CR>

" quit vim with leader q
nnoremap  <leader>q :q<CR>

" quit vim without saving  leader Q
nnoremap  <leader>Q :q!<CR>

" command mode with leader c
nnoremap  <leader>c :

" command line with leader C
nnoremap  <leader>C :!

" yank to * with leader y
vnoremap <leader>y +y
nnoremap  <leader>yy +yy

" del to + with leader d
vnoremap <leader>d +d
nnoremap <leader>dd +dd

" paste from + with leader p
nnoremap <leader>p +p
nnoremap <leader>P +P

" keep visual selection when tabbing
vnoremap > >gv
vnoremap < <gv
