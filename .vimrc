let mapleader = '\'
map <space> <leader>
set timeoutlen=4000

"Weird interaction with backspace, not sure what was going on but this fixes it.
set backspace=indent,eol,start
"Linux Plugins
set runtimepath^=~/.vimfiles/bundles/ctrlp.vim
set runtimepath^=~/.vimfiles/bundles/nerdtree
set runtimepath^=~/.vimfiles/bundles/vim-vinegar

"Windows versions of plugins
set runtimepath^=~/vimfiles/ctrlp.vim
set runtimepath^=~/vimfiles/vim-vinegar
set runtimepath^=~/vimfiles/colors
set runtimepath^=~/vimfiles/tabular
set runtimepath^=~/vimfiles/vim-table-mode

syntax enable
set textwidth=0 
set wrapmargin=0

set tabstop=4
set shiftwidth=0
set relativenumber
set number

nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

nnoremap <leader>ev :split $MYVIMRC<cr>
nnoremap <leader>wv ZZ:source $MYVIMRC<cr>
colorscheme bwebs
