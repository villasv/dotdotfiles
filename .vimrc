if exists('g:vscode') " Using Neovim inside VSCode
else " Using regular vim/Neovim
	if empty(glob('~/.vim/autoload/plug.vim')) " install Plug and plugins on first use
	  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
		\ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
	endif
	call plug#begin()
	Plug 'altercation/vim-colors-solarized'	" solarized colors
	Plug 'scrooloose/nerdtree'				" tree explorer
	Plug 'junegunn/fzf'						" fuzzy finder base
	Plug 'junegunn/fzf.vim'					" fuzzy finder cmds
	Plug 'skywind3000/asyncrun.vim'			" shell commander
	Plug 'tpope/vim-fugitive'				" git commands
	Plug 'airblade/vim-gitgutter'			" git side markings
	Plug 'leafgarland/vim-polyglot'			" languages pack
	Plug 'dense-analysis/ale'               " async lint engine
	call plug#end()
endif

" general settings
syntax enable					" syntax hightlight for known languages
set number relativenumber		" current line number with relative jumps
set updatetime=300				" faster updates for git diff markers
set autoindent					" copy indentation from previous line
set smartindent					" guess when more indentation is needed
set tabstop=4					" sane default of 4 characters wide tabs
set shiftwidth=4				" spaces per shift (should equal tabstop)
set foldmethod=indent			" allow folding per indent levels
set foldlevel=5					" set a sane default of initial folding
set backspace=indent,eol,start	" allow backspace to delete everything


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
map <Leader>to :NERDTreeFind<CR>
map <Leader>tt :NERDTreeToggle<CR>
map <Leader>ff :Files<CR>
map <Leader>fe :Rg<CR>
map <Leader>cl :AsyncRun 
map <Leader>ch :History:<CR>

" insert mode mappings
inoremap jj <esc>

" global lint configs
let g:ale_fix_on_save = 1
let g:ale_sign_error = '!>'
let g:ale_sign_warning = '?>'

" custom extension associations
autocmd BufRead,BufNewFile *.template set filetype=yaml
