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

"call this when vim starts
call ToggleCC(range(81,90))

"Viewing shortcuts
nnoremap <leader>vw :set wrap!<cr>
nnoremap <silent> <leader>vs :call ToggleListChars()<cr>

