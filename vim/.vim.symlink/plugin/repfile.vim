" repfile.vim: file replacer

" Doc

" Installation: put repfile.vim in your .vim/plugin/ and restart vim
" If you'd like to remap the function call, put following in your .vimrc
"       let g:RepCall="yourmapping"

" Usage: the default mapping is set to <leader>R (leader is the \ key, if
" you haven't customized. So in a default configuration of vim a \rep would
" bring up the function call. Just enter the desired new filename and press
" enter. The new file will be saved, the buffer opened, the old file deleted
" if was written to disk and its buffer closed.

" default mapping
if !exists("g:RepCall")
    let g:RepCall="<leader>R"
endif

exec "map " . g:RepCall . " :RepFile <c-r>=expand('%:p:h')<cr>/"

function! RepFile(newfile)
    let oldfile=expand("%")
    let newfile=a:newfile
    silent execute 'w ' . newfile
    if !exists('g:BufKillCommandWhenLastBufferKilled')
        bw
    else
        BW
    endif

    if filereadable(oldfile) == 1
        silent execute '!rm ' . oldfile
    endif
    silent execute 'e ' . newfile
endfunction

command! -bang -nargs=* -complete=file RepFile call RepFile(<q-args>)
