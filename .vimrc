" install plugins on first use
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin()
Plug 'scrooloose/nerdtree'				" tree explorer
Plug 'junegunn/fzf'						" files finder
Plug 'junegunn/fzf.vim'					" fzf integrations
Plug 'altercation/vim-colors-solarized'	" solarized colors
Plug 'airblade/vim-gitgutter'			" git diff markers
Plug 'tpope/vim-fugitive'				" git commands
call plug#end()

" general settings
syntax enable				" syntax hightlight for known languages
colorscheme solarized		" activate solarized color palette
set number relativenumber	" current line number with relative jumps
set autoindent				" copy indentation from previous line
set smartindent				" guess when more indentation is needed
set updatetime=1000			" faster updates for git diff markers
set tabstop=4				" sane default of 4 spaces wide tabs

" searching
set ignorecase			" ignore case when searching by default
set smartcase			" unless search terms contain upper case

" buffers
set hidden				" hide buffers instead of closing them
set confirm				" ask to save on closing edited buffer
set scrolloff=3			" scroll buffer in advance of a few lines

" touch typing home changes
let mapleader = " "
noremap ; l
noremap l k
noremap k j
noremap j h
noremap <C-w>; <C-w>l
noremap <C-w>l <C-w>k
noremap <C-w>k <C-w>j
noremap <C-w>j <C-w>h

" mappings
set showcmd							" show when leader is waiting for key
set timeoutlen=500					" shorten how much leader will wait
map <Leader>t :NERDTreeToggle<CR>
map <Leader>f :Files<CR>
map <Leader>c :History:<CR>
map <Leader>g :Rg<CR>

