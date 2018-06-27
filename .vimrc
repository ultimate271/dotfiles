set encoding=utf-8
set fileencoding=utf-8

"Define where the vim bundles are for plugins
if has('win32')
    let $VIMHOME = $HOME."/vimfiles"
else
    let $VIMHOME = $HOME."/.vim"
endif

"Plugins
set nocompatible
filetype off
set rtp+=$VIMHOME/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
Plugin 'tpope/vim-vinegar'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'godlygeek/tabular'
"Plugin 'wincent/scalpel'
"Plugin 'haya14busa/incsearch.vim'
Plugin 'vim-scripts/folddigest.vim'
"Plugin 'scrooloose/nerdtree'
Plugin 'jeetsukumaran/vim-buffergator'
Plugin 'tpope/vim-projectionist'
"Plugin 'Valloric/YouCompleteMe'
Plugin 'tpope/vim-fugitive'
call vundle#end()
filetype plugin indent on

"ctrlp options
let g:ctrlp_show_hidden = 1

"Scrolling goodness (winheight(win_getid())-x)/2 where x is the 'wiggle room'
"augroup VCenterCursor
"    au!
"    au BufEnter,WinEnter,WinNew,VimResized *,*.* 
"        \ let &scrolloff=(winheight(win_getid())-12)/2
"augroup END


syntax enable
if filereadable(expand("$VIMHOME/colors/bdubcolor.vim"))
    colorscheme bdubcolor
else
    colorscheme slate
endif
