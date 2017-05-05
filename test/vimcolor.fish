
set -q fish_color_autosuggestion  ; or set -U fish_color_autosuggestion
set -q fish_color_command         ; or set -U fish_color_command
set -q fish_color_comment         ; or set -U fish_color_comment
set -q fish_color_cwd             ; or set -U fish_color_cwd
set -q fish_color_cwd_root        ; or set -U fish_color_cwd_root
set -q fish_color_end             ; or set -U fish_color_end
set -q fish_color_error           ; or set -U fish_color_error
set -q fish_color_escape          ; or set -U fish_color_escape
set -q fish_color_history_current ; or set -U fish_color_history_current
set -q fish_color_host            ; or set -U fish_color_host
set -q fish_color_match           ; or set -U fish_color_match
set -q fish_color_normal          ; or set -U fish_color_normal
set -q fish_color_operator        ; or set -U fish_color_operator
set -q fish_color_param           ; or set -U fish_color_param
set -q fish_color_quote           ; or set -U fish_color_quote
set -q fish_color_redirection     ; or set -U fish_color_redirection
set -q fish_color_search_match    ; or set -U fish_color_search_match
set -q fish_color_selection       ; or set -U fish_color_selection
set -q fish_color_status          ; or set -U fish_color_status
set -q fish_color_user            ; or set -U fish_color_user
set -q fish_color_valid_path      ; or set -U fish_color_valid_path

set -l old_fish_color_end $fish_color_end
set -l old_fish_color_match $fish_color_match
set -l old_fish_color_escape $fish_color_escape
set -l old_fish_color_selection $fish_color_selection

vimcolor default

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

