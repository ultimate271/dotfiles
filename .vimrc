"Fun stuff with the leader key
let mapleader = '\'
map <space> <leader>
set timeoutlen=4000

"Weird interaction with backspace, not sure what was going on but this fixes it.
set backspace=indent,eol,start

"Define where the vim bundles are for plugins
if has('win32')
	let $VIMHOME = $HOME."/vimfiles"
else
	let $VIMHOME = $HOME."/.vim"
endif

"plugins
set rtp+=$VIMHOME/bundles/ctrlp.vim
set rtp+=$VIMHOME/bundles/vim-vinegar
set rtp+=$VIMHOME/bundles/tabular
set backupdir=$VIMHOME/backup

"Line number goodness
set relativenumber
set number

"Options to make the idotic automatic text wrapping go away
set textwidth=0 
set wrapmargin=0

"Prefer tabs over spaces
"set noexpandtab
"Tabs and spaces
augroup pythonsettings
	autocmd!
	autocmd FileType python setlocal expandtab
	autocmd FileType python setlocal foldmethod=indent
	autocmd FileType python setlocal foldignore=
augroup END
set tabstop=4
set shiftwidth=4
set softtabstop=4
set copyindent
set autoindent

set listchars=space:.
set listchars^=eol:$
set listchars^=tab:>-

nnoremap <silent> <C-h> :set nowrap<cr><C-w>h:vertical resize 80<cr>
nnoremap <silent> <C-j> :set nowrap<cr><C-w>j:vertical resize 80<cr>
nnoremap <silent> <C-k> :set nowrap<cr><C-w>k:vertical resize 80<cr>
nnoremap <silent> <C-l> :set nowrap<cr><C-w>l:vertical resize 80<cr>

"Easily edit this file
nnoremap <leader>ev :25split $MYVIMRC<cr>
nnoremap <leader>wv ZZ:source $MYVIMRC<cr>
nnoremap <leader>ec :split $VIMHOME/colors/bdubcolor.vim<cr>
"Viewing shortcuts
nnoremap <leader>vw :set wrap!<cr>
nnoremap <leader>vs :set list!<cr>
"Insert Text
nnoremap <leader>-- 80i-<esc>
nnoremap <leader>o o<esc>k
nnoremap <leader>O O<esc>j
nnoremap <leader>f<space> :%s/	/    /g<cr>

vnoremap = :Tab /=<cr>

syntax enable
if filereadable(expand("$VIMHOME/colors/bdubcolor.vim"))
	colorscheme bdubcolor
else
	colorscheme slate
endif
