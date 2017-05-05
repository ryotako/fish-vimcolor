function vimcolor -a scheme -d 'convert a vim-colorscheme into a fish-colorscheme'
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
   
    __vimcolor_set_color $tmp fish_color_normal          Normal
    __vimcolor_set_color $tmp fish_color_command         Statement
    __vimcolor_set_color $tmp fish_color_quote           String
    __vimcolor_set_color $tmp fish_color_redirection     Directory
    __vimcolor_set_color $tmp fish_color_end             Delimiter
    __vimcolor_set_color $tmp fish_color_error           Error
    __vimcolor_set_color $tmp fish_color_param           Identifier
    __vimcolor_set_color $tmp fish_color_comment         Comment
    __vimcolor_set_color $tmp fish_color_match           MatchParen
    __vimcolor_set_color $tmp fish_color_search_match    Search
    __vimcolor_set_color $tmp fish_color_operator        Operator
    __vimcolor_set_color $tmp fish_color_escape          SpecialChar
    __vimcolor_set_color $tmp fish_color_autosuggestion  Comment
    __vimcolor_set_color $tmp fish_color_valid_path      Underlined
    __vimcolor_set_color $tmp fish_color_history_current Directory
    __vimcolor_set_color $tmp fish_color_selection       Visual

    rm $tmp
end

function __vimcolor_set_color -a tmp fish_group vim_group
    while read -l line
        set -l attrs (string match -r "^$vim_group .*gui=(\w+(,\w+)*)" $line)
        set -l color (string match -r "^$vim_group .*guifg=#?(\w+)"    $line)
        set -l bkg   (string match -r "^$vim_group .*guibg=#?(\w+)"    $line)
        set -l to_eval ''

        # foreground color
        set -q color[2]; and set to_eval "$to_eval $color[2]"
        
        # background color
        set -q bkg[2]; and set to_eval "$to_eval --background=$bkg[2]"

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
            echo -n (eval set_color $to_eval)"set $fish_group $to_eval"
            echo (set_color normal)
            eval "set $fish_group $to_eval"
            return
        end
        
        # links to another syntax group
        set -l link (string match -r "^$vim_group .*links to (\w+).*" $line)
        if test $status = 0
            __vimcolor_set_color $tmp $fish_group $link[2]
            return
        end
    end < $tmp
end
end
