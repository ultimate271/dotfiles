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
set nocompatible
filetype off
set rtp+=$VIMHOME/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
Plugin 'tpope/vim-vinegar'
Plugin 'kien/ctrlp.vim'
Plugin 'godlygeek/tabular'
call vundle#end()
filetype plugin indent on
"set rtp+=$VIMHOME/bundle/ctrlp.vim
"set rtp+=$VIMHOME/bundle/vim-vinegar
"set rtp+=$VIMHOME/bundle/tabular
set backupdir=$VIMHOME/backup

"Line number goodness
set relativenumber
set number

"Options to make the idotic automatic text wrapping go away
set textwidth=0 
set wrapmargin=0

"Scrolling goodness (winheight(win_getid())-x)/2 where x is the 'wiggle room'
augroup VCenterCursor
    au!
    au BufEnter,WinEnter,WinNew,VimResized *,*.* 
        \ let &scrolloff=(winheight(win_getid())-12)/2
augroup END

"Custom Folding Goodness
set foldmethod=expr
set foldexpr=MyFoldExpr(v:lnum)
set foldtext=MyFoldText()
set foldlevel=1

"Prefer spaces (for now)
set expandtab
set tabstop=4
set shiftwidth=4
set softtabstop=4
set copyindent
set autoindent

"What to toggle to see whitespace
set listchars=space:.
set listchars^=eol:$
set listchars^=tab:>-

"Leader key pnumonics
"Chords
    "<leader>e = edit
        "v = vimrc
        "c = vimcolors
    "<leader>w = write
        "v = vimrc
    "<leader>v = view
        "w = word wrap
        "s = whitespace
        "c = 80 width column
        "l = layout
    "<leader>f = format
        "<space> = replace all tabs with spaces
"Key Presses
    "<leader>h l = navigate buffers
    "<leader>p P = special pasting hotkeys
    "<leader>d = blackhole register
"Key Remapping
"Easily edit this file
nnoremap <leader>ev :tabedit $MYVIMRC<cr>
nnoremap <leader>wv ZZ:source $MYVIMRC<cr>
nnoremap <leader>ec :tabedit $VIMHOME/colors/bdubcolor.vim<cr>
"Viewing shortcuts
nnoremap <leader>vw :set wrap!<cr>
nnoremap <leader>vs :set list!<cr>
nnoremap <silent> <leader>vc :call ToggleCC(80)<cr>
nnoremap <silent> <leader>vl :call ToggleCC("1,5,9,13,17,21,25")<cr>
"Insert Text
inoremap --- <esc>80i-<esc>A
nnoremap <leader>f<space> :%s/	/    /g<cr>
"Put whats in the current buffer to various places end of the file
nnoremap <leader>p mr$p`r
nnoremap <leader>P mrGp`r
"Blackhole Register
nnoremap <leader>d "_
nnoremap c "_c
"Folding
nnoremap <C-z> za
"Easily select clipboard register
nnoremap <C-c> "*
vnoremap <C-c> "*
inoremap <C-c> <C-r>*
"Easily select registers in general
nnoremap " '
nnoremap ' "
vnoremap " '
vnoremap ' "
"Tab Creation and Switching
nnoremap gh gT
nnoremap gl gt
nnoremap gt :tabedit .<cr>
nnoremap gw :tabclose<cr>
"Buffer Switching
nnoremap <leader>h :bprevious<cr>
nnoremap <leader>l :bnext<cr>
"Easy Pane Navigation
set winminwidth=20
nnoremap <silent> <C-h> :set nowrap<cr><C-w>h:vertical resize 88<cr>
nnoremap <silent> <C-j> :set nowrap<cr><C-w>j:vertical resize 88<cr>
nnoremap <silent> <C-k> :set nowrap<cr><C-w>k:vertical resize 88<cr>
nnoremap <silent> <C-l> :set nowrap<cr><C-w>l:vertical resize 88<cr>
"Tabulate shortcut
vnoremap = :Tab /=<cr>
"Visual Mode Remaps
vnoremap J j
vnoremap K k

"Functions for folding
function! IndentLevel(lnum)
    return indent(a:lnum) / &shiftwidth
endfunction

function! NextNonBlankLine(lnum)
    let numlines = line('$')
    let current = a:lnum + 1
    while current <= numlines
        if getline(current) =~ '\v\S'
            return current
        endif
        let current += 1
    endwhile
    
    return -2
endfunction

function! MyFoldExpr(lnum)
    let this_indent = IndentLevel(a:lnum) + 1
    let next_indent = IndentLevel(NextNonBlankLine(a:lnum)) + 1

    if getline(a:lnum) =~ '\v^\s*$'
        if next_indent == 1
            return '0'
        else
            return '-1'
        endif
    endif

    if this_indent >= next_indent
        return "".this_indent
    elseif this_indent < next_indent
        return ">".next_indent
    endif
endfunction

function! MyFoldText()
    let numlines = v:foldend - v:foldstart + 1
    return getline(v:foldstart)." ".v:folddashes." [FOLDED] ".numlines." lines "
endfunction

function! ToggleCC(colno)
    if &colorcolumn != ""
        set colorcolumn=
    else
        let &colorcolumn=a:colno
    endif
endfunction

syntax enable
if filereadable(expand("$VIMHOME/colors/bdubcolor.vim"))
    colorscheme bdubcolor
else
    colorscheme slate
endif
