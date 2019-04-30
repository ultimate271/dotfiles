command Pandoc call DoPandoc()

function! DoPandoc()
    wa
    if filereadable("pandoc.bat")
        ! .\pandoc.bat
    elseif filereadable("metadata.yaml")
        ! pandoc -o"out.pdf" "%" "metadata.yaml"
    else
        ! pandoc -o"out.pdf" "%"
    endif
endfunction
