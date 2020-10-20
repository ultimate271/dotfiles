command Pdf call DoPdfCommand()
command Pandoc call DoPandocCommand()
command Read call DoRead()
command Cd call DoCd()

let g:PandocCompile=1
autocmd TextChanged * :let g:PandocCompile=1
autocmd TextChangedI * :let g:PandocCompile=1

function! DoPdfCommand()
    wa
    ! pdflatex "%"
endfunction

function! DoPandocCommand()
    if has('nvim')
        call DoPandocAsync()
    else
        call DoPandoc()
    endif
endfunction

function! DoPandoc()
    wa
    if expand('%:t') == 'pandoc.bat'
        call DoCd()
        ! .\pandoc.bat
    elseif filereadable("metadata.yaml")
        ! pandoc -o"out.pdf" "%" "metadata.yaml"
    else
        ! pandoc -o"out.pdf" "%"
    endif
    let g:PandocCompile = 0
endfunction

function! DoCd()
    let l:fulldirname = expand('%:p:h')
    execute 'cd ' . l:fulldirname
endfunction

function! DoPandocAsync()
    wa
    let l:command = 'pandoc.bat'
    if expand('%:t') == 'pandoc.bat'
        call DoCd()
        let l:command = 'pandoc.bat'
    elseif filereadable("metadata.yaml")
        let l:command = 'pandoc -o"out.pdf" "'.expand("%:t").'" "metadata.yaml"'
    else
        let l:command = 'pandoc -o"out.pdf" "'.expand("%:t").'"'
    endif
    let l:optsdict = {'on_exit':{j,d,e-> OnPandocExit(d, l:command)}}
    call jobstart(l:command, l:optsdict)
    let g:PandocCompile = 0
endfunction

function DoRead()
    call DoCd()
    if (g:PandocCompile)
        call DoPandocAsync()
    else
        call LaunchSumatraAsync('out.pdf')
    endif
endfunction

function! OnPandocExit(d, command)
    if (a:d == 0)
        call LaunchSumatraAsync('out.pdf')
    else
        echoerr "External pandoc command is too weak! > " . a:command
    endif
endfunction

function! LaunchSumatraAsync(filename)
    let l:filename = ''
    if filereadable(a:filename)
        let l:filename = a:filename
    else
        if filereadable('bin\'.a:filename)
            let l:filename = 'bin\'.a:filename
        endif
    endif
    if has('nvim')
        call jobstart('SumatraPDF ' . l:filename)
    else
        ! SumatraPDF l:filename
    endif
endfunction
