"Literary Annotations
nnoremap <silent> <leader>a mx"xyiw?^#<cr>o{Actor:<C-r>x}<esc>`x:noh<cr>
vnoremap <silent> <leader>a mx"xy?^#<cr>o{Actor:<C-r>x}<esc>`x:noh<cr>
nnoremap <silent> <leader>s mx"xyiw?^#<cr>o{Scene:<C-r>x}<esc>`x:noh<cr>
vnoremap <silent> <leader>s mx"xy?^#<cr>o{Scene:<C-r>x}<esc>`x:noh<cr>
nnoremap <silent> <leader>r mx"xyiw?^#<cr>o{Reference:<C-r>x}<esc>`x:noh<cr>
vnoremap <silent> <leader>r mx"xy?^#<cr>o{Reference:<C-r>x}<esc>`x:noh<cr>

function! TagHeaders()
    let i = 1
    let numLines = line('$')
    let headerCount = {}
    while i <= numLines
        let headerinfo = matchstr(getline(i), '\v^#+')
        let hlevel = strlen(headerinfo)
        if hlevel > 0
            "Sanitize the dictionary
            for j in range(1, hlevel)
                if has_key(headerCount, j)
                else
                    let headerCount[j] = 0
                endif
            endfor

            "Reset the deeper levels
            let j = hlevel + 1
            while has_key(headerCount, j)
                let headerCount[j] = 0
                let j = j + 1
            endwhile

            "Increment the header
            if has_key(headerCount, hlevel)
                let headerCount[hlevel] = headerCount[hlevel] + 1
            endif

            "Build the idstring
            let idstring = ''
            for j in range(1, hlevel - 1)
                let idstring = idstring . headerCount[j] . '.'
            endfor
            let idstring = idstring . headerCount[hlevel]

            "build the newline based on the current one
            "let currenttag = matchstr(getline(i), '\v^#+.*\{\zs.*\ze\}')
            let newline = getline(i)
            let newline = substitute(newline, '\v\{.*\}', '', 'g') "Remove any pre-existing tags
            "let newline = substitute(getline(i), '\v(^#+ )(\{.*\})?.*(\}.*)', '\1' . idstring . '\2', '')
            let newline = substitute(newline, '\v(^#+)(.*)', '\1{' . idstring . '}\2', '')

            "actually put the line in the file
            call setline(i, newline)
        endif
        let i = i + 1
    endwhile

endfunction

