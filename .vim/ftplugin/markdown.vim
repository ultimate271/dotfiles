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
    elseif nline =~ '\v^-+$' || cline =~ '\v##[^#]+'
        return '>2'
    elseif exists("g:foldparagraph") && strlen(pline) == 0 && strlen(cline) != 0
        return '>3'
    else
        return '='
    endif
endfunction

"Foldtext for markdown files
function! FoldTextMarkdown()
    let numlines = v:foldend - v:foldstart + 1
    let fl = strlen(v:folddashes)
    let foldtext = v:folddashes." [FOLDED] ".numlines." lines ".v:folddashes."    "
    let linetext = strpart(getline(v:foldstart), 0, &columns - strlen(foldtext))
    let prefix = ""
    if (getline(v:foldstart)[0] != '#' && fl < 3)
        let prefix = repeat("#", fl)
    endif
    let padding = repeat(" ", &columns - strlen(linetext) - strlen(foldtext))
    return "".prefix.linetext.padding.foldtext
endfunction

