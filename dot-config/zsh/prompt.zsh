# NOTE: PS1 and PROMPT are the same thing

# NOTE: If not using NixOS (with programs.git.enable = true), then you need to
# source git-prompt.sh manually 

# autoload -Uz add-zsh-hook vcs_info
# setopt prompt_subst
# add-zsh-hook precmd vcs_info
# add ${vcs_info_msg_0} to the prompt
# e.g. here we add the Git information in red  
### Git-prompt from webpage
# PROMPT='%1~ %F{red}${vcs_info_msg_0_}%f %# '
### Old prompt without git:
# PROMPT='%F{green}[%F{white}%B%3~%b%F{green}]%(!.#.$) %f'

### New prompt. Explanation:
### General info
# Literal characters ([, ], $): Just insert literal text
# %-sign: Indicates a command
### Specific values
# %n		Username
# %m		Hostname
# %j		The number of jobs currently managed by the shell.
# %L		The current value of the $SHLVL variable.
# %T		The current time in 24-hour format.
# %r		Show current time in a 12-hour format with seconds.
# %D		Show the date in "yyyy-mm-dd" format.
# %3~		Show directory + up to 2 up, with ~ for home-directory
### Commands
# %F{<color>}		Sets color of next term
# %B...%b		Bold texst in between
# %U...%u		Underline
# %S...%s		Highlight
# %K{<color>...%k	Change background color
# PROMPT="%L"
NEWLINE=$'\n'	# Lul, doesn't work with "\n", need single-quotes

### See: https://digitalfortress.tech/tutorial/setting-up-git-prompt-step-by-step/
# GIT_PS1_SHOWDIRTYSTATE=true
# GIT_PS1_SHOWSTASHSTATE=true
# GIT_PS1_SHOWUNTRACKEDFILES=true
# GIT_PS1_SHOWUPSTREAM="auto"
# GIT_PS1_HIDE_IF_PWD_IGNORED=true
# GIT_PS1_SHOWCOLORHINTS=true

# Set symbols


# NOTE: Suggested symbols (most of them are not currently implemented)
# * - unstaged changes
# ? - untracked files
# = - in sync with upstream
# ↓ - behind upstream
# ↑ - ahead of upstream
# ↕ - diverged
# + - staged changes
# $ - stashed files (or use "s" which might be clearer)

# INFO: Default values at: https://github.com/olivierverdier/zsh-git-prompt/blob/master/zshrc.sh
ZSH_THEME_GIT_PROMPT_PREFIX=""
ZSH_THEME_GIT_PROMPT_SUFFIX=" "
ZSH_THEME_GIT_PROMPT_SEPARATOR=" "
ZSH_THEME_GIT_PROMPT_BRANCH="%F{#d891ef} %B"
ZSH_THEME_GIT_PROMPT_STAGED="%{$fg_bold[red]%}%{+%}"
ZSH_THEME_GIT_PROMPT_CONFLICTS="%{$fg_bold[red]%}%{✖%}%G"
ZSH_THEME_GIT_PROMPT_CHANGED="%{$fg_bold[red]%}%{*%}%G"
ZSH_THEME_GIT_PROMPT_BEHIND="%{$fg_bold[yellow]↓%}%G"
ZSH_THEME_GIT_PROMPT_AHEAD="%{$fg_bold[yellow]↑%}%G"
ZSH_THEME_GIT_PROMPT_UNTRACKED="%{$fg_bold[red]?%}%G"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg_bold[green]%}%{✔%}%G"


GIT_PROMPT_EXECUTABLE="haskell"

BACKGROUND_PROCESSES="%(1j.%F{red}bg count: %j%f .)"

# NOTE: Text containing $(git_super_status) to be single quotes ', otherwise it
# is not continously updated
PROMPT_DIR="%F{cyan}%B%3~ %b%f"
# PROMPT_SEP="%F{green}%(!.#. )%f"
PROMPT_SEP="%B%F{green}%(!.#.>)%f%b "
PROMPT='$SHELL_PROMPT$PROMPT_DIR$(git_super_status)$BACKGROUND_PROCESSES$PROMPT_SEP'
# RPROMPT='$(git_super_status)'


### Indicator for being in direnv-environemnt
function precmd() {
  ### Checks if anything from nix store has been added to path, which should
  # only happen when we are in a nix shell, nix develop or direnv
  if [[ "$PATH" == */nix/store/* ]]; then
    SHELL_PROMPT="%F{blue}󱄅 %f"
  else
    SHELL_PROMPT=""
  fi
  ### More advanced version, if nix/store is somehow added to path
  # if [[ "$PATH" == */nix/store/* && ( -n "$DIRENV_DIR" || -n "$IN_NIX_SHELL" || "$SHLVL" -gt 1 ) ]]; then
}
