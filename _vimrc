source $VIMRUNTIME/vimrc_example.vim
"source $VIMRUNTIME/mswin.vim
"source ~/vimfiles/marvim/marvim.vim

behave mswin

"Linux Plugins
set runtimepath^=~/.vimfiles/bundles/ctrlp.vim
set runtimepath^=~/.vimfiles/bundles/nerdtree
set runtimepath^=~/.vimfiles/bundles/vim-vinegar

"Windows versions of plugins
set runtimepath^=~/vimfiles/ctrlp.vim
set runtimepath^=~/vimfiles/vim-vinegar
set runtimepath^=~/vimfiles/colors

colorscheme jellybeans

set textwidth=0 
set wrapmargin=0

set tabstop=4
set relativenumber
set number

command NT NERDTree

nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

set diffexpr=MyDiff()
function MyDiff()
  let opt = '-a --binary '
  if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
  if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
  let arg1 = v:fname_in
  if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
  let arg2 = v:fname_new
  if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
  let arg3 = v:fname_out
  if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
  if $VIMRUNTIME =~ ' '
    if &sh =~ '\<cmd'
      if empty(&shellxquote)
        let l:shxq_sav = ''
        set shellxquote&
      endif
      let cmd = '"' . $VIMRUNTIME . '\diff"'
    else
      let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
    endif
  else
    let cmd = $VIMRUNTIME . '\diff'
  endif
  silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3
  if exists('l:shxq_sav')
    let &shellxquote=l:shxq_sav
  endif
endfunction

