command Pandoc call DoPandoc()

function! DoPandoc()
    wa
    !Pandoc -o "out.pdf" "%"
endfunction
