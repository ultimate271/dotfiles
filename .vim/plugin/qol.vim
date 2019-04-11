"Line number goodness
set relativenumber
set number

set backspace=indent,eol,start          "Set backspace to allow running back through lines and such
set textwidth=0                         "Allow text width to go beyond 80 characters
set wrapmargin=0                        "Similar to above
set hidden                              "Has to do with buffer hiding
set visualbell                          "These two have to do with bells, fuck bells
set t_vb=
set shortmess^=I                        "Don't show intro

set nobackup                            "Fuck ~ files and etc.
set nowritebackup
set noswapfile
set viminfo=

"Spaces over tabs
set expandtab
set tabstop=4
set shiftwidth=4
set softtabstop=4
set copyindent
set autoindent

"Show White Space
set list
set listchars=trail:◆
set listchars+=tab:>-

set virtualedit=block                   "ctrl-v selects block even if there are characters there

let g:ctrlp_open_new_file = 'r'
