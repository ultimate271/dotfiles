command Pandoc call DoPandoc()

function! DoPandoc()
    wa
    let yamlFilename = "metadata.yaml"
    if filereadable(yamlFilename)
        ! pandoc -o"out.pdf" "%" "metadata.yaml"
    else
        ! pandoc -o"out.pdf" "%"
    endif
endfunction
