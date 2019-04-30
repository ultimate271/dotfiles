command Pandoc call DoPandoc()

function! DoPandoc()
    wa
    ! pandoc -o"out.pdf" "%"
endfunction
