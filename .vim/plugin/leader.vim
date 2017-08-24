"Fun stuff with the leader key
let mapleader = '\'
map <space> <leader>
set timeoutlen=4000

"Easily edit vimrc
nnoremap <leader>ev :tabedit $MYVIMRC<cr>
nnoremap <leader>wv ZZ:source $MYVIMRC<cr>
nnoremap <leader>ec :tabedit $VIMHOME/colors/bdubcolor.vim<cr>
nnoremap <leader>eh :tabedit $VIMHOME/plugin/leader.vim<cr>

"Viewing shortcuts
nnoremap <leader>vw :set wrap!<cr>
nnoremap <leader>vs :set list!<cr>
nnoremap <silent> <leader>vc :call ToggleCC(80)<cr>
nnoremap <silent> <leader>vl :call ToggleCC("1,5,9,13,17,21,25")<cr>

"Blackhole Register
nnoremap <leader>d "_
nnoremap c "_c

"Easily select clipboard register
nnoremap <C-c> "*
vnoremap <C-c> "*
inoremap <C-c> <C-r>*

"Insert Text
inoremap --- <esc>80i-<esc>A
nnoremap <leader>f<space> :%s/	/    /g<cr>
nnoremap <leader>p mr$p`r
nnoremap <leader>P mrGp`r

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