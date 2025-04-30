alias ls="eza --group-directories-first --icons=auto"
alias l="eza -l --total-size --no-permissions -h --git --icons=auto"
alias cp="cp -i" # Interactive
alias df="df -h"
alias free="free -m"
alias bc="bc -l"
# hms="home-manager switch --flake /etc/nixos" # opt: #angryluck
# hm="home-manager --flake /etc/nixos" # opt: #angryluck
alias sudo="sudo "
alias nrs="nixos-rebuild switch"
### Replace by better script, that forces to write commit msg.
# alias nrs="~/util/nixos-rebuild.sh" 
alias nrt="nixos-rebuild test"
alias polybar-refresh="pkill polybar; polybar -c ~/.config/polybar/config.ini default&; disown"
# alias polybar-refresh="pkill polybar; setsid polybar -c ~/.config/polybar/config.ini default&; disown"
            # setsid xdg-open "$1" &>/dev/null
    # Temporarily needed, delete later
# alias popcp="cp mothApp.fsx ../../virtual-box-share/pop-3/src/";
alias dotstow="stow -R -d ~/dotfiles . --dotfiles"
alias cat="bat"
alias nix dev="nix develop --command zsh"
alias lg="lazygit"

##############################
# git aliases
##############################
alias gs="git status --short"
alias gd="git diff"
alias ga="git add"
alias gap="git add --patch" # Add line by line
alias gc="git commit"
alias gp="git push"
alias gu="git pull"
alias gl="git log --all --graph"
alias gb="git branch"
alias gw="git switch"
# Not needed, used so rarely
# alias gi="git init"
# alias gcl="git clone"
