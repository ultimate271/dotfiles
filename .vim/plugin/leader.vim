"Fun stuff with the leader key
let mapleader = '\'
map <space> <leader>
set timeoutlen=4000
"Some changes
"Some more changes

"Easily edit vimrc
nnoremap <leader>ev :tabedit $MYVIMRC<cr>
nnoremap <leader>wv ZZ:source $MYVIMRC<cr>
nnoremap <leader>ec :tabedit $VIMHOME/colors/bdubcolor.vim<cr>
nnoremap <leader>wc ZZ:source $MYVIMRC<cr>
nnoremap <leader>eh :tabedit $VIMHOME/plugin/leader.vim<cr>
nnoremap <leader>wh ZZ:source $VIMHOME/plugin/leader.vim<cr>
nnoremap <silent> <leader>ww :w<cr>:source %<cr>

"Tab Creation and Switching
nnoremap gh gT
nnoremap gl gt
nnoremap gt :tabedit .<cr>
nnoremap gw :tabclose<cr>
nnoremap <leader>h :bnext<cr>
nnoremap <leader>l :bprevious<cr>

"Easy Pane Navigation
set winminwidth=20
nnoremap <silent> <C-h> :set nowrap<cr><C-w>h:vertical resize 88<cr>
"nnoremap <silent> <C-j> :set nowrap<cr><C-w>j:vertical resize 88<cr>
nnoremap <silent> <C-j> j<C-e>
"nnoremap <silent> <C-k> :set nowrap<cr><C-w>k:vertical resize 88<cr>
nnoremap <silent> <C-k> k<C-y>
nnoremap <silent> <C-l> :set nowrap<cr><C-w>l:vertical resize 88<cr>

"Scalpel Remap
"nmap <Leader>s <Plug>(Scalpel)
"vmap <Leader>s <Plug>(ScalpelVisual)
"nnoremap <silent> <leader>n :noh<cr>

"Incremntal Search
"map /  <Plug>(incsearch-forward)
"map ?  <Plug>(incsearch-backward)
"map g/ <Plug>(incsearch-stay)
set hlsearch
set ignorecase
set smartcase

"Convienience mappings
"nnoremap H ^
"nnoremap L $
"vnoremap J j
"vnoremap K k

"Close one buffer at a time
command Q bdelete
command WQ call WBDelete()

function! WBDelete()
    execute "w"
    execute "bdelete"
endfunction
