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
# $env.LS_COLORS = (dircolors)
### LS_COLORS
source ls-colors.nu
$env.config.table.mode = "light"
$env.LANG = "en_US.UTF-8"  # TODO: Set this in NixOS-config
$env.AFP = "~/AFP/afp-2025-07-07/thys"
$env.ISABELLE_HOME = "~/.isabelle"
$env.RULES = "/etc/nixos/configuration/secrets/_secrets.nix"
# Risky hack, to increase POSIX-compliance
# $env.SHELL = "zsh"

$env.config.keybindings ++= [{
    name: quit
    modifier: control
    keycode: char_q
    mode: emacs

    event: { send: executehostcommand cmd: "exit" }
}]


alias vimr = nvim -R --cmd 'set nomodifiable'

# $env.config.edit_mode = "vi"


    # let id = $id | into string

def --env jd [id: string, id2?:string] {
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
    let split: list<string> = if $id2 == null {
        if (($id | str length) == 4) {
            [($id | str substring 0..1) ($id | str substring 2..3) ]
        } else {
          $id | split row "."
        }
    } else {
        [$id $id2]
    }
    let arg_count = $split | length
    let arg_len = $split  |  str length

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
    let top_dir = ls ~/JD/ | find_prefix $ten_prefix
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
def sep [program: path] {
    ^setsid -f $program o+e> /dev/null
}

def start [file: path] {
  ^setsid -f xdg-open $file o+e> /dev/null
}

# def sep [...cmd] {
#     ^setsid -f ...$cmd o+e> /dev/null
# }

# Size is useless, it doesn't recursively get size of directory. Use eza for that
# def l --wrapped [...args] {
#     if ($args | is-empty) {ls .} else {ls -s ...$args} |
#     sort-by type name -i |
#     reject type size
# }

def l [path?: path] {
    ^eza --icons=auto --group-directories-first (if ($path == null) {$env.PWD} else $path)
}

def la [path?: path] {
    ^eza -a --icons=auto --group-directories-first (if ($path == null) {$env.PWD} else $path)
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



let direnv_reload = { ||
    # SOURCE: https://github.com/nushell/nu_scripts/blob/main/nu-hooks/nu-hooks/direnv/config.nu
    if (which direnv | is-empty) {
        return
    }

    direnv export json | from json | default {} | load-env
    # Direnv outputs $PATH as a string, but nushell silently breaks if isn't a list-like table.
    # The following behemoth of Nu code turns this into nu's format while following the standards of how to handle quotes, use it if you need quote handling instead of the line below it:
    # $env.PATH = $env.PATH | parse --regex ('' + `((?:(?:"(?:(?:\\[\\"])|.)*?")|(?:'.*?')|[^` + (char env_sep) + `]*)*)`) | each {|x| $x.capture0 | parse --regex `(?:"((?:(?:\\"|.))*?)")|(?:'(.*?)')|([^'"]*)` | each {|y| if ($y.capture0 != "") { $y.capture0 | str replace -ar `\\([\\"])` `$1` } else if ($y.capture1 != "") { $y.capture1 } else $y.capture2 } | str join }
    $env.PATH = $env.PATH | split row (char env_sep)
}


# NOTE: Only on dir change work poorly when I keep changing development-flakes...
$env.config.hooks.pre_prompt = (
    $env.config.hooks.pre_prompt | append $direnv_reload
)

# cdls
def cl --env [path?:path] {
    if ($path == null) {cd} else {cd $path}
    ^eza --icons=auto --group-directories-first
}
# Yazi
def --env y [...args] {
	let tmp = (mktemp -t "yazi-cwd.XXXXXX")
	yazi ...$args --cwd-file $tmp
	let cwd = (open $tmp)
	if $cwd != "" and $cwd != $env.PWD {
		cd $cwd
	}
	rm -fp $tmp
}

# use completions-jj.nu *


def --env shell [pkgs:string]  {
    with-env { IN_NIX_SHELL: 1 }  { nix shell $"nixpkgs#($pkgs)" --command nu }
}

def run [pkgs:string]  {
    nix run $"nixpkgs#($pkgs)"
}


# Restart network-connect
def restart-network [] {
    nmcli device disconnect wlp1s0
    nmcli device connect wlp1s0
}


##################################################
# Templates
##################################################
def nix-module [name:string] {
    module=$name envsubst -i ~/.local/share/templates/modules.nix -no-unset -no-empty
}


def mirror [] {
  ^setsid -f wl-present mirror eDP-1 --fullscreen-output HDMI-A-1 o> /dev/null
}


# Should be at the end of config.nu
source ($nu.default-config-dir | path join zoxide.nu)

# For iteration run `oh-my-posh enable reload`
oh-my-posh init nu --config ~/.config/oh-my-posh/zen.yaml

def --env chat [] {
    cd ~/JD/00-09_Meta/03_Program-data/gemini-cli/
    gemini
}

alias cpcv = cp ~/JD/20-29_Praktisk/21_Professionelt/21.11_CV/out/cv.pdf .

alias rp = rg

# Command to develop from the system flake:
def develop [] {
    nix develop -c nu
}

alias z = job unfreeze

# ${UserConfigDir}/nushell/config.nu
source $"($nu.cache-dir)/carapace.nu"


alias fg = job unfreeze

alias tmp = cd /tmp
