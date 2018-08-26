command Done call AddCommitPush()

function AddCommitPush()
    Git add --all
    Gcommit -m"A commit"
    Gpush
endfunction
