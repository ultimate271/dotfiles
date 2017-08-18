let mapleader = '\'
map <space> <leader>
set timeoutlen=4000

if has('win32')
	let $VIMHOME = $HOME."/vimfiles"
else
	let $VIMHOME = $HOME."/.vim"
endif
"Weird interaction with backspace, not sure what was going on but this fixes it.
set backspace=indent,eol,start

"plugins
set rtp+=$VIMHOME/bundles/ctrlp.vim
set rtp+=$VIMHOME/bundles/vim-vinegar
set rtp+=$VIMHOME/bundles/tabular
set backupdir=$VIMHOME/backup

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
nnoremap <leader>fw :set wrap!<cr>
nnoremap <leader>-- 80i-<esc>
nnoremap <leader>o o<esc>k
nnoremap <leader>O O<esc>j

syntax enable
if filereadable(expand("$VIMHOME/colors/bdubcolor.vim"))
	colorscheme bdubcolor
else
	colorscheme slate
endif
