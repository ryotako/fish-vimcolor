set -l old_fish_color_end $fish_color_end
set -l old_fish_color_match $fish_color_match
set -l old_fish_color_escape $fish_color_escape
set -l old_fish_color_selection $fish_color_selection

alias vim /usr/bin/vim
vimcolor default

set | grep 'fish_color'

test "fish_color_end"
    "$old_fish_color_end" = "$fish_color_end"
end

test "fish_color_match"
    "$old_fish_color_match" = "$fish_color_match"
end

test "fish_color_escape"
    "$old_fish_color_escape" = "$fish_color_escape"
end

test "fish_color_selection"
    "$old_fish_color_selection" = "$fish_color_selection"
end

test "fish_color_command"
    "ffff60 --bold" = "$fish_color_command"
end

test "fish_color_quote"
    "ffa0a0" = "$fish_color_quote"
end

test "fish_color_redirection"
    "Cyan" = "$fish_color_redirection"
end

test "fish_color_error"
    "White --background=Red" = "$fish_color_error"
end

test "fish_color_param"
    "40ffff" = "$fish_color_param"
end

test "fish_color_comment"
    "80a0ff" = "$fish_color_comment"
end

test "fish_color_search_match"
    "Black --background=Yellow" = "$fish_color_search_match"
end

test "fish_color_operator"
    "ffff60 --bold" = "$fish_color_operator"
end

test "fish_color_autosuggestion"
    "80a0ff" = "$fish_color_autosuggestion"
end

test "fish_color_valid_path"
    "80a0ff --underline" = "$fish_color_valid_path"
end

test "fish_color_history_current"
    "Cyan" = "$fish_color_history_current"
end

