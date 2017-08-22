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

"Key Remapping
"Easily edit this file
nnoremap <leader>ev :tabedit $MYVIMRC<cr>
nnoremap <leader>wv ZZ:source $MYVIMRC<cr>
nnoremap <leader>ec :split $VIMHOME/colors/bdubcolor.vim<cr>
"Viewing shortcuts
nnoremap <leader>vw :set wrap!<cr>
nnoremap <leader>vs :set list!<cr>
"Insert Text
nnoremap <leader>-- 80i-<esc>
nnoremap <leader>o o<esc>k
nnoremap <leader>O O<esc>j
nnoremap <leader>f<space> :%s/    /    /g<cr>
"Folding
nnoremap <C-c> za
"Tab Creation and Switching
nnoremap gh gT
nnoremap gl gt
nnoremap gt :tabedit .<cr>
nnoremap gw :tabclose<cr>
"Easy Pane Navigation
set winminwidth=20
nnoremap <silent> <C-h> :set nowrap<cr><C-w>h:vertical resize 88<cr>
nnoremap <silent> <C-j> :set nowrap<cr><C-w>j:vertical resize 88<cr>
nnoremap <silent> <C-k> :set nowrap<cr><C-w>k:vertical resize 88<cr>
nnoremap <silent> <C-l> :set nowrap<cr><C-w>l:vertical resize 88<cr>
"Tabulate shortcut
vnoremap = :Tab /=<cr>

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

syntax enable
if filereadable(expand("$VIMHOME/colors/bdubcolor.vim"))
    colorscheme bdubcolor
else
    colorscheme slate
endif
