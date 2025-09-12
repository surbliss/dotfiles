# config.nu
#
# Installed by:
# version = "0.105.1"
#
# This file is used to override default Nushell settings, define
# (or import) custom commands, or run any other startup tasks.
# See https://www.nushell.sh/book/configuration.html
#
# This file is loaded after env.nu and before login.nu
#
# You can open this file in your default editor using:
# config nu
#
# See `help config nu` for more options
#
# You can remove these comments if you want or leave
# them for future reference.

### Prompt
$env.PROMPT_COMMAND_RIGHT = ""
# $env.TRANSIENT_PROMPT_COMMAND_RIGHT = ""
$env.TRANSIENT_PROMPT_COMMAND_RIGHT = ""
$env.TRANSIENT_PROMPT_COMMAND = ""

$env.config.buffer_editor = "hx"
$env.config.show_banner = false

$env.LS_COLORS = (dircolors)
$env.config.table.mode = "light"

# $env.config.edit_mode = "vi"

def --env jd [id] {
  cd jd
}

# Size is useless, it doesn't recursively get size of directory. Use eza for that
def l --wrapped [...args] {
    if ($args | is-empty) {ls .} else {ls ...$args} |
    sort-by type name -i |
    reject type size
}

alias reload = exec nu # Doesn't work on windows
alias dotstow = stow -R -d ~/dotfiles . --dotfiles
alias bach = exec nohup isabelle jedit -l Collections ~/Documents/1-projekter/bachelor-project/Modular_Decomposition/LexBFS.thy

# alias ls = exec eza --icons=auto --group-directories-first
# alias l = eza -l --total-size --no-permissions --no-user -h --git --icons=auto --group-directories-first

# alias l = ls | sort-by type


$env.config.hooks.env_change = {
    PWD:  [{ ||
    if (which direnv | is-empty) {
        return
    }

    direnv export json | from json | default {} | load-env
    }]
}



# Should be at the end of config.nu
source ($nu.default-config-dir | path join zoxide.nu)

# For iteration run `oh-my-posh enable reload`
oh-my-posh init nu --config ~/.config/oh-my-posh/zen.yaml
