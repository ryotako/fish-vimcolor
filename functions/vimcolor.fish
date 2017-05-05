function vimcolor -a scheme -d 'convert a vim-colorscheme into a fish-colorscheme'

    function __vimcolor_usage
        echo "Name: vimcolor - Convert vim-colorscheme into a fish-colorscheme!"
        echo
        echo "Usage:"
        echo "    vimcolor [options] [vim-colorscheme]"
        echo
        echo "Options:"
        echo "    -h, --help     show this help message"
    end

    set -l options
    set -l scheme
    while count $argv >/dev/null
        switch $argv[1]
            case -h --help
                __vimcolor_usage
                return
            case '--'
                if set -q argv[2]
                    set scheme $argv[2]
                    set -e argv[2]
                end
            case '-*'
                echo "vimcolor: unknown option '$argv[1]'" >/dev/stderr
                return 1
            case '*'
                set scheme $scheme $argv[1]
        end
        
        set -e argv[1]
    end

    if test (count $scheme) -gt 1
        echo "vimcolor: select only one colorscheme" >/dev/null
        return 1
    end

    function __vimcolor_convert -a tmp fish_group vim_group -V options
        while read -l line
            set -l attrs (string match -r "^$vim_group .*gui=(\w+(,\w+)*)" $line)
            set -l color (string match -r "^$vim_group .*guifg=#?(\w+)"    $line)
            set -l bkg   (string match -r "^$vim_group .*guibg=#?(\w+)"    $line)
            set -l to_eval ''

            # foreground color
            if set -q color[2]
                if begin
                        not string match -qr '^[0-9a-fa-f]{6}$' $color[2]
                        and not string match -iq $color[2] (set_color -c)
                    end
                    echo "vimcolor: color of $vim_group '$color[2]' is unknown" >/dev/stderr
                else
                    set to_eval "$to_eval $color[2]"
                end
            end

            # background color
            if set -q bkg[2]
                if begin
                        not string match -qr '^[0-9a-fa-f]{6}$' $bkg[2]
                        and not string match -iq $bkg[2] (set_color -c)
                    end
                    echo "vimcolor: background color of $vim_group '$bkg[2]' is unknown" >/dev/stderr
                else
                    set to_eval "$to_eval --background=$bkg[2]"
                end
            end

            # attributes list
            if set -q attrs[2]
                set attrs (string split , $attrs[2])

                contains underline $attrs; and set to_eval "$to_eval --underline"
                contains bold      $attrs; and set to_eval "$to_eval --bold"
                contains italic    $attrs; and set to_eval "$to_eval --italics"
                contains reverse   $attrs; and set to_eval "$to_eval --reverse"
                contains inverse   $attrs; and set to_eval "$to_eval --reverse"
            end

            # execute set_color
            if string length -q $to_eval
                echo -n (eval set_color $to_eval)"set fish_color_$fish_group $to_eval"
                echo (set_color normal)
                eval "set fish_color_$fish_group $to_eval"
                return
            end

            # links to another syntax group
            set -l link (string match -r "^$vim_group .*links to (\w+).*" $line)
            if test $status = 0
                __vimcolor_convert $tmp $fish_group $link[2]
                return
            end
        end <$tmp
    end

    # get the colorscheme information from vim
    set -l tmp (mktemp)
    vim $tmp -e\
     +'set nonumber'\
     +"colorscheme $scheme"\
     +'redir @a'\
     +'colorscheme'\
     +'highlight'\
     +'redir END'\
     +'put a'\
     +'wq!'

    __vimcolor_convert $tmp normal Normal
    __vimcolor_convert $tmp command Statement
    __vimcolor_convert $tmp quote String
    __vimcolor_convert $tmp redirection Directory
    __vimcolor_convert $tmp end Delimiter
    __vimcolor_convert $tmp error Error
    __vimcolor_convert $tmp param Identifier
    __vimcolor_convert $tmp comment Comment
    __vimcolor_convert $tmp match MatchParen
    __vimcolor_convert $tmp search_match Search
    __vimcolor_convert $tmp operator Operator
    __vimcolor_convert $tmp escape SpecialChar
    __vimcolor_convert $tmp autosuggestion Comment
    __vimcolor_convert $tmp valid_path Underlined
    __vimcolor_convert $tmp history_current Directory
    __vimcolor_convert $tmp selection Visual

    rm $tmp
end

