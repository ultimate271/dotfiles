"Literary Annotations
nnoremap <silent> <leader>a mx"xyiw?^#<cr>o[Actor]: # {<C-r>x}<esc>`x:noh<cr>
vnoremap <silent> <leader>a mx"xy?^#<cr>o[Actor]: # {<C-r>x}<esc>`x:noh<cr>
nnoremap <silent> <leader>s mx"xyiw?^#<cr>o[Speaker]: # {<C-r>x}<esc>`x:noh<cr>
vnoremap <silent> <leader>s mx"xy?^#<cr>o[Speaker]: # {<C-r>x}<esc>`x:noh<cr>
nnoremap <silent> <leader>c mx"xyiw?^#<cr>o[Character]: # {<C-r>x}<esc>`x:noh<cr>
vnoremap <silent> <leader>c mx"xy?^#<cr>o[Character]: # {<C-r>x}<esc>`x:noh<cr>
nnoremap <silent> <leader>l mx"xyiw?^#<cr>o[Location]: # {<C-r>x}<esc>`x:noh<cr>
vnoremap <silent> <leader>l mx"xy?^#<cr>o[Location]: # {<C-r>x}<esc>`x:noh<cr>
nnoremap <silent> <leader>p mx"xyiw?^#<cr>o[Place]: # {<C-r>x}<esc>`x:noh<cr>
vnoremap <silent> <leader>p mx"xy?^#<cr>o[Place]: # {<C-r>x}<esc>`x:noh<cr>
nnoremap <silent> <leader>o mx"xyiw?^#<cr>o[Object]: # {<C-r>x}<esc>`x:noh<cr>
vnoremap <silent> <leader>o mx"xy?^#<cr>o[Object]: # {<C-r>x}<esc>`x:noh<cr>
nnoremap <silent> <leader>i mx"xyiw?^#<cr>o[Item]: # {<C-r>x}<esc>`x:noh<cr>
vnoremap <silent> <leader>i mx"xy?^#<cr>o[Item]: # {<C-r>x}<esc>`x:noh<cr>
nnoremap <silent> <leader>e mx"xyiw?^#<cr>o[Event]: # {<C-r>x}<esc>`x:noh<cr>
vnoremap <silent> <leader>e mx"xy?^#<cr>o[Event]: # {<C-r>x}<esc>`x:noh<cr>
nnoremap <silent> <leader>m mx"xyiw?^#<cr>o[Myth]: # {<C-r>x}<esc>`x:noh<cr>
vnoremap <silent> <leader>m mx"xy?^#<cr>o[Myth]: # {<C-r>x}<esc>`x:noh<cr>
nnoremap <silent> <leader>r mx"xyiw?^#<cr>o[Reference]: # {<C-r>x}<esc>`x:noh<cr>
vnoremap <silent> <leader>r mx"xy?^#<cr>o[Reference]: # {<C-r>x}<esc>`x:noh<cr>
nnoremap <silent> <leader>g "tyi{:tag <C-r>t<cr>
vnoremap <silent> <leader>g "ty:tag <C-r>t<cr>
nnoremap <silent> <leader>1 mx?\v(^$\|^#)<cr>:noh<cr>o# <esc>`x
nnoremap <silent> <leader>2 mx?\v(^$\|^#)<cr>:noh<cr>o## <esc>`x
nnoremap <silent> <leader>3 mx?\v(^$\|^#)<cr>:noh<cr>o### <esc>`x
nnoremap <silent> <up> ?^#<cr>zt

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
            let santag = SanitizeTag(currenttag)
            if currenttag != ""
                call SubInList(reffile, '\v\{' . santag . '\}', '{ ' . newtag . ' }', 'g') "Use spaces on the replacement to guard them
                call SubInList(tagfile, '\v\{' . santag . '\}', '{ ' . newtag . ' }', 'g') "Replace the regex in the tags file
                call SubInList(tagfile, '\v^' . santag . '	', ' ' . newtag . '	', '') "And the actual tag itself
            else
                "Build the new tag line
                let tagline = ' ' . newtag . '	' . expand('%:t') . '	' . '/^#\+{ ' . newtag . ' }'
                call add(tagfile, tagline)
            endif
        endif
    endfor

    "Remove any guards we may have placed earlier
    call SubInList(reffile, '\v\{ ([^ \}]*) \}', '{\1}', 'g')
    call SubInList(tagfile, '\v\{ ([^ \}]*) \}', '{\1}', 'g')
    call SubInList(tagfile, '\v^ ([^	]*	)', '\1', 'g')

    "Delete any tags that used to be in this particular file that are not anymore
    for i in reverse(range(0, len(tagfile) - 1))
        let thistagfilename = matchstr(tagfile[i], '\v[^	]*	\zs[^	]*\ze	')
        if thistagfilename ==? expand('%:t')
            let currenttag = matchstr(tagfile[i], '\v^\zs[^	]*\ze	')
            let pattern = '\v^#+\{' . SanitizeTag(currenttag) . '\}'
            let deleteline = 1
            for j in range(1, numLines)
                if getline(j) =~? pattern
                    let deleteline = 0
                    break
                endif
            endfor
            if deleteline
                call remove(tagfile, i)
            endif
        endif
    endfor

    "Delete any duplicate tags (and I'm lazy so it's quadratic running time and it looks gross
    let i = 0
    let length = len(tagfile) - 1
    while i < length
        let currenttagfilename = matchstr(tagfile[i], '\v[^	]*	\zs[^	]*\ze	')
        if currenttagfilename ==? expand('%:t')
            let currenttag = matchstr(tagfile[i], '\v^\zs[^	]*\ze	')
            let j = i + 1
            while j < length
                let comparetagfilename = matchstr(tagfile[j], '\v[^	]*	\zs[^	]*\ze	')
                if comparetagfilename ==? expand('%:t')
                    let comparetag = matchstr(tagfile[j], '\v^\zs[^	]*\ze	')
                    if comparetag ==? currenttag
                        call remove(tagfile, j)
                        let length = len(tagfile) - 1
                        let j = j - 1
                    endif
                endif
                let j = j + 1
            endwhile
        endif
        let i = i + 1
    endwhile

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

