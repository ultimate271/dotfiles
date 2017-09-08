set encoding=utf-8

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
Plugin 'kien/ctrlp.vim'
Plugin 'godlygeek/tabular'
Plugin 'wincent/scalpel'
Plugin 'haya14busa/incsearch.vim'
Plugin 'vim-scripts/folddigest.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'terryma/vim-smooth-scroll'
"Plugin 'Valloric/YouCompleteMe'
call vundle#end()
filetype plugin indent on
set backupdir=$VIMHOME/backup

"ctrlp options
let g:ctrlp_show_hidden = 1

"Line number goodness
set relativenumber
set number

"Stuff that makes vim usable
set backspace=indent,eol,start
set textwidth=0
set wrapmargin=0
set hidden
set visualbell
set t_vb=
set shortmess^=I

"Scrolling goodness (winheight(win_getid())-x)/2 where x is the 'wiggle room'
augroup VCenterCursor
    au!
    au BufEnter,WinEnter,WinNew,VimResized *,*.* 
        \ let &scrolloff=(winheight(win_getid())-12)/2
augroup END

"Prefer spaces (for now)
set expandtab
set tabstop=4
set shiftwidth=4
set softtabstop=4
set copyindent
set autoindent
set list
set listchars=trail:◆

"What to toggle to see whitespace
function! ToggleListChars()
    if exists("g:showwhite")
        unlet g:showwhite
        set listchars-=space:.
        set listchars-=eol:$
        set listchars-=tab:>-
    else
        let g:showwhite = 1
        set listchars^=space:.
        set listchars^=eol:$
        set listchars^=tab:>-
    endif
endfunction

"Toggle Color Column
function! ToggleCC(collist)
    let cclist = split(&colorcolumn, ",")
    for i in a:collist
        if index(cclist, "".i) == -1
            execute "set colorcolumn^=".i
        else
            execute "set colorcolumn-=".i
        endif
    endfor
endfunction

"Visually see 80 lines
call ToggleCC(range(81,255))

syntax enable
if filereadable(expand("$VIMHOME/colors/bdubcolor.vim"))
    colorscheme bdubcolor
else
    colorscheme slate
endif
