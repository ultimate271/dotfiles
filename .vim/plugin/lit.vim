"Literary Annotations
nnoremap <silent> <leader>a mx"xyiw?^#<cr>o{Actor:<C-r>x}<esc>`x:noh<cr>
vnoremap <silent> <leader>a mx"xy?^#<cr>o{Actor:<C-r>x}<esc>`x:noh<cr>
nnoremap <silent> <leader>s mx"xyiw?^#<cr>o{Scene:<C-r>x}<esc>`x:noh<cr>
vnoremap <silent> <leader>s mx"xy?^#<cr>o{Scene:<C-r>x}<esc>`x:noh<cr>
nnoremap <silent> <leader>r mx"xyiw?^#<cr>o{Reference:<C-r>x}<esc>`x:noh<cr>
vnoremap <silent> <leader>r mx"xy?^#<cr>o{Reference:<C-r>x}<esc>`x:noh<cr>
nnoremap <silent> <leader>g "tyi{:tag <C-r>t<cr>

function! TagHeaders()
    let i = 1
    let numLines = line('$')
    let headerCount = {}
    let reffilename = expand('%:p:h') . '/reference.md'
    let tagfilename = expand('%:p:h') . '/tags'
    if !filereadable(reffilename)
        call writefile([], reffilename)
    endif
    if !filereadable(tagfilename)
        call writefile([], tagfilename)
    endif
    let reffile = readfile(reffilename)
    let tagfile = readfile(tagfilename)

    for i in range(1, numLines)
        let headerinfo = matchstr(getline(i), '\v^#+')
        let hlevel = strlen(headerinfo)
        if hlevel > 0
            "Sanitize the dictionary
            for j in range(1, hlevel)
                if !has_key(headerCount, j)
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

            "Build the newtag
            let newtag = expand('%:t:r') . '.'
            for j in range(1, hlevel - 1)
                let newtag = newtag . headerCount[j] . '.'
            endfor
            let newtag = newtag . headerCount[hlevel]

            "build the newline based on the current one
            let newline = getline(i)
            let currenttag = matchstr(getline(i), '\v^#+\{\zs[^\}]*\ze\}') "Capture the pre-existing tag before overwriting it
            let newline = substitute(newline, '\v^(#+)\{[^\}]*\}', '\1', '') "Remove any pre-existing tags
            let newline = substitute(newline, '\v(^#+)(.*)', '\1{' . newtag . '}\2', '') "Insert the new tag

            "actually put the line in the file
            call setline(i, newline)

            "Update the tags file and the reference file
            if currenttag != ""
                let santag = SanitizeTag(currenttag)
                echo currenttag
                echo santag
                echo newtag
                echo tagfile
                call SubInList(reffile, '\v\{' . santag . '\}', '{ ' . newtag . ' }', 'g') "Use spaces on the replacement to guard them
                call SubInList(tagfile, '\v\{' . santag . '\}', '{ ' . newtag . ' }', 'g') "Replace the regex in the tags file
                call SubInList(tagfile, '\v^' . santag . '	', ' ' . newtag . '	', '') "And the actual tag itself
            endif
        endif
    endfor

    "Remove any guards we may have placed earlier
    call SubInList(reffile, '\v\{ ([^ \}]*) \}', '{\1}', 'g')
    call SubInList(tagfile, '\v\{ ([^ \}]*) \}', '{\1}', 'g')
    call SubInList(tagfile, '\v^ ([^	]*	)', '\1', 'g')
    call writefile(reffile, reffilename)
    call writefile(tagfile, tagfilename)
endfunction

function! SubInList(mylist, pattern, replacement, tags)
    for i in range(0, len(a:mylist) - 1)
        let a:mylist[i] = substitute(a:mylist[i], a:pattern, a:replacement, a:tags)
    endfor
endfunction

function! SanitizeTag(tag)
    return substitute(a:tag, '\v\.', '\\.', 'g')
endfunction

