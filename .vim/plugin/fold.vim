"Custom Folding Goodness
set foldmethod=expr
set foldexpr=MyFoldExpr(v:lnum)
set foldtext=MyFoldText()
set nofoldenable
"set foldlevel=1

"Folding
nnoremap <C-z> za

"Function from line number to indent level of the line
function! IndentLevel(lnum)
    return indent(a:lnum) / &shiftwidth
endfunction

"Function that returns the line number of the next non blank line
function! NextNonBlankLine(lnum)
    let numlines = line('$')
    let current = a:lnum + 1
    while current <= numlines
        if getline(current) =~ '\v\S'
            return current
        endif
        let current += 1
    endwhile
    
    return -2
endfunction

"The foldexpr generator itself
function! MyFoldExpr(lnum)
    let this_indent = IndentLevel(a:lnum) + 1
    let next_indent = IndentLevel(NextNonBlankLine(a:lnum)) + 1

    if getline(a:lnum) =~ '\v^\s*$'
        if next_indent == 1
            return '0'
        else
            return '-1'
        endif
    endif

    if this_indent >= next_indent
        return "".this_indent
    elseif this_indent < next_indent
        return ">".next_indent
    endif
endfunction

"Function that makes folded text look better
function! MyFoldText()
    let numlines = v:foldend - v:foldstart + 1
    let foldtext = v:folddashes." [FOLDED] ".numlines." lines ".v:folddashes."    "
    let linetext = strpart(getline(v:foldstart), 0, &columns - strlen(foldtext))
    let padding = repeat(" ", &columns - strlen(linetext) - strlen(foldtext))
    return "".linetext.padding.foldtext
endfunction
