setlocal foldmethod=expr
setlocal foldexpr=FoldExprMarkdown(v:lnum)
setlocal foldtext=FoldTextMarkdown()
nnoremap <silent> <leader>zp :call ToggleParagraph()<cr>

function! ToggleParagraph()
    if exists("g:foldparagraph")
        unlet g:foldparagraph
    else
        let g:foldparagraph=1
    endif
endfunction

"Foldexpr for txt files
function! FoldExprMarkdown(lnum)
    let pline = getline(a:lnum - 1)
    let cline = getline(a:lnum)
    let nline = getline(a:lnum + 1)
    if nline =~ '\v^\=+$' || cline =~ '\v^#[^#]+'
        return '>1'
    elseif nline =~ '\v^-+$' || cline =~ '\v^##[^#]+'
        return '>2'
    elseif cline =~ '\v^###[^#]+'
        return '>3'
    elseif cline =~ '\v^####[^#]+'
        return '>4'
    elseif cline =~ '\v^#####[^#]+'
        return '>5'
    elseif cline =~ '\v^######[^#]+'
        return '>6'
    "elseif exists("g:foldparagraph") && strlen(pline) == 0 && strlen(cline) != 0
    "    return '>4'
    else
        return '='
    endif
endfunction

"Foldtext for markdown files
function! FoldTextMarkdown()
    let fl = strlen(v:folddashes)
    let prefix = ""
    if (getline(v:foldstart)[0] != '#' && fl < 3)
        let prefix = repeat("#", fl)
    endif
    return MyFoldText(prefix)
endfunction

