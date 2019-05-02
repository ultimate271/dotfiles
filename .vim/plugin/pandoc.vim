command Pandoc call DoPandoc()
command Cd call DoCd()

function! DoPandoc()
    wa
    if expand('%:t') == 'pandoc.bat'
        call DoCd()
        ! .\pandoc.bat
"    elseif filereadable("pandoc.bat")
"        ! .\pandoc.bat
    elseif filereadable("metadata.yaml")
        ! pandoc -o"out.pdf" "%" "metadata.yaml"
    else
        ! pandoc -o"out.pdf" "%"
    endif
endfunction

function! DoCd()
    let l:fulldirname = expand('%:p:h')
    execute 'cd ' . l:fulldirname
endfunction
