" install plugins on first use
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin()
Plug 'scrooloose/nerdtree'	" directory tree explorer
Plug 'tpope/vim-fugitive'	" git commands inside vim
Plug 'junegunn/fzf'		" files fuzzy finder
call plug#end()

" general settings
syntax enable			" syntax hightlight for known languages
set number relativenumber	" current line number with relative jumps
set autoindent			" copy indentation from previous line
set smartindent			" guess when more indentation is needed

" searching
set ignorecase			" ignore case when searching by default
set smartcase			" unless search terms contain upper case

" buffers
set hidden			" hide buffers instead of closing them
set confirm			" ask to save on closing edited buffer
set scrolloff=3			" scroll buffer in advance of a few lines

" mappings
let mapleader = " "		" uses spacebar as leader touch typing
set showcmd			" show when leader is waiting for key
set timeoutlen=500		" shorten how much leader will wait
map <Leader>t :NERDTreeToggle<CR>
map <Leader>f :FZF<CR>

" home row remaps
noremap ; l
noremap l k
noremap k j
noremap j h
noremap <C-w>; <C-w>l
noremap <C-w>l <C-w>k
noremap <C-w>k <C-w>j
noremap <C-w>j <C-w>h

