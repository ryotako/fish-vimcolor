function __vimcolor_colorschemes
    vim -es -u '~/.vimrc' \
    +'set nonumber' \
    +'redir @a' \
    +'echo globpath(&runtimepath, \'colors/*.vim\')' \
    +'redir END' \
    +'put a' \
    +'%p' \
    +'q!' | while read -l line
        set -l scheme (string match -r '([^/]+)\.vim' $line)
        and echo $scheme[2]
    end
    true
end

complete -c vimcolor -d 'convert a vim-colorscheme into a fish-colorscheme!'
complete -c vimcolor -s h -l help 'show help message'
complete -f -c vimcolor -a '(__vimcolor_colorschemes)'
