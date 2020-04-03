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
Plug 'dense-analysis/ale'               " async lint engine
Plug 'tpope/vim-fugitive'				" git commands
call plug#end()

" general settings
syntax enable				" syntax hightlight for known languages
colorscheme solarized		" activate solarized color palette
set number relativenumber	" current line number with relative jumps
set updatetime=300			" faster updates for git diff markers
set autoindent				" copy indentation from previous line
set smartindent				" guess when more indentation is needed
set tabstop=4				" sane default of 4 characters wide tabs
set shiftwidth=4			" spaces per shift (should equal tabstop)
set foldmethod=indent		" allow folding per indent levels

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

" general mappings
set showcmd							" show command about to be executed
set timeoutlen=500					" shorten how much leader will wait
map <Leader>tt :NERDTreeToggle<CR>
map <Leader>tf :NERDTreeFind<CR>
map <Leader>f :Files<CR>
map <Leader>c :History:<CR>
map <Leader>g :Rg<CR>

" insert mode mappings
inoremap jj <esc>

" global lint configs
let g:ale_fix_on_save = 1
let g:ale_sign_error = '!>'
let g:ale_sign_warning = '?>'

" custom extension associations
autocmd BufRead,BufNewFile *.template set filetype=yaml
