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
$env.LANG = "en_US.UTF-8"  # TODO: Set this in NixOS-config
$env.AFP = "~/AFP/afp-2025-07-07/thys"
$env.ISABELLE_HOME = "~/.isabelle"


# $env.config.edit_mode = "vi"


    # let id = $id | into string

def --env jd [id: string] {
    # Helper function to find directory corresponding to given index
    def find_prefix [prefix] {
        where ($it.name | path basename) starts-with $prefix |
        get name |
        if ($in | length) > 1 {
            error make -u {msg: "Prefix not unique"}
        } else if ($in | length) == 0 {
            error make -u { msg: "Prefix not found" }   
        } else {
            get 0
        }
    }
    let $split = $id | split row "."
    let arg_count = $split | length
    let arg_len = $split | str length

    # Pre data validations
    # Length = 0 is handled by argument being required
    if $arg_count == 1 and not ($arg_len.0 in [1 2]) {
        error make -u {msg: "Invalid single index"} 
    }
    if $arg_count == 2 and ($arg_len.0 != 2 or $arg_len.1 != 2) {
        error make -u {msg: "Invalid index-pair"} 
    }
    if $arg_count > 2 {
        error make -u {msg: "Too many periods"} 
    }

    let ten_prefix = $split.0 | str substring 0..0 | $in + "0"
    let top_dir = ls ~/Documents/ | find_prefix $ten_prefix
    if ($split.0 | str length) == 1 {
        cd $top_dir
        return
    }
    let main_dir = ls $top_dir | find_prefix $split.0
    if $arg_count == 1 {
        cd $main_dir
        return
    }
    let second_dir = ls $main_dir | find_prefix ($split | str join ".")
    cd $second_dir
}

# Overriden 'start' func
def start [file: path] {
  ^setsid -f xdg-open $file o+e> /dev/null
}

# Size is useless, it doesn't recursively get size of directory. Use eza for that
# def l --wrapped [...args] {
#     if ($args | is-empty) {ls .} else {ls -s ...$args} |
#     sort-by type name -i |
#     reject type size
# }

def l [...dir] {
    ^eza --icons=auto --group-directories-first (
        if ($dir | is-empty) {$env.PWD} else $dir)
}

alias reload = exec nu # Doesn't work on windows
alias dotstow = stow -R -d ~/dotfiles . --dotfiles
def bach --env [] {
    let bach_path = "/home/angryluck/Documents/10-19_Nørklen/14_Uni-Datalogi/14.24_Bachelor-projekt_LexBFS/LexBFS/LexBFS.thy"
    # Need isabelle components -u (full path) first!
    ^setsid -f isabelle jedit -R LexBFS $bach_path o> /dev/null
}
    # ^setsid -f (isabelle jedit -d ~/Documents/10-19_Nørklen/14_Uni-Datalogi/14.24_Bachelor-projekt_Modular_Decomposition/Modular_Decomposition/LexBFS.thy -l LexBFS ~/Documents/10-19_Nørklen/14_Uni-Datalogi/14.24_Bachelor-projekt_Modular_Decomposition/Modular_Decomposition/LexBFS.thy) o+e> /dev/null}
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

# cdls
def cl --env [dir] {
    cd $dir
    ^eza --icons=auto --group-directories-first
}

use completions-jj.nu *

# Should be at the end of config.nu
source ($nu.default-config-dir | path join zoxide.nu)

# For iteration run `oh-my-posh enable reload`
oh-my-posh init nu --config ~/.config/oh-my-posh/zen.yaml
