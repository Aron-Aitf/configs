function copy --description "Copy pipe or argument"
    if [ "$argv" = "" ]
        xclip -sel clip
    else
        printf "$argv" | xclip -sel clip
    end
end

function copypath --description "Copy full file path"
    readlink -e $argv | xclip -sel clip
end

function run --description "Make file executable, then run it"
    chmod +x "$argv"
    eval "./$argv"
end

function randname --description "Random name for registration on random websites. How about Helen Lovick? Roger Rice?"
    curl -s "https://randomuser.me/api/" | jq -r '.results[0].name.first + " " + .results[0].name.last'
end

function randalias --description "Docker-like alias generator: `thirsty_mahavira`, `boring_heisenberg`. Don't know how to name file/project/branch/file? Use this!"
    curl -s https://frightanic.com/goodies_content/docker-names.php
end

function randpass --description "Generate random password" --argument-names length
    test -n "$length"; or set length 13
    head /dev/urandom | tr -dc "[:alnum:]~!#\$%^&*-+=?./|" | head -c $length
end

function randfact --description "Print random useless fact. Makes checking if internet is available little less boring"
    curl -s https://uselessfacts.jsph.pl/api/v2/facts/random | jq .text
end

function localip --description "Shows (local) internal ip"
    ip -o route get to 1.1.1.1 | sed -n 's/.*src \([0-9.]\+\).*/\1/p'
end

function fish_greeting
end

function make_venv --description "make a python virtual environment" --argument-names venv_name
    python -m venv $venv_name
    source $venv_name/bin/activate.fish
end

function list_path --description "Pretty Print Path variable"
    echo $PATH | tr ' ' '\n' | sort
end

function fish_remove_path --description "Remove a path from Path variable" --argument-names file_path
    if set -l index (contains -i $file_path $PATH)
        set -e PATH[$index]
    end
end

if status is-interactive
    zoxide init fish | source

    # Clear screen on Ctrl+U
    bind \cu 'cls;  commandline -f repaint'

    starship init fish | source

    fzf --fish | source

    set -x EDITOR code-insiders
    set -x VISUAL code-insiders

    if test "$TERM_PROGRAM" != vscode
        fastfetch
    end

end
