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
