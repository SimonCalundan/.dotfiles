autoload -Uz vcs_info
precmd() { vcs_info }
zstyle ':vcs_info:git:*' formats '%b '

setopt PROMPT_SUBST
PROMPT='%F{#0C97FA}%*%f %F{#16E1F5}%~%f %F{red}${vcs_info_msg_0_}%f$ '
function cdfzf() {
    local dir="$(find ~/Desktop -type d -not -path '*/\.*' -not -path '*/node_modules/*' | fzf --preview 'ls {}')"
    [ -d "$dir" ] && cd "$dir"
}
function ffzf() {
    local file="$(find ~/Desktop -type f -not -path '*node_modules*' | fzf --preview 'bat --style=numbers --color=always {}' || echo '')"
    if [ -n "$file" ] && [ -f "$file" ]; then
        nvim "$file"
    else
        echo "No file selected."
    fi
}

