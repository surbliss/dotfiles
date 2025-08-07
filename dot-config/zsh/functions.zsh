# Complicated aliases
function arkiver() {
    if [ $# -eq 1 ]; then
        if [ -e "$1" ]; then
	    if [ -e "$1/.direnv" ]; then
	      echo "Removing .direnv cache"
	      trash "$1/.direnv"
	      trash -f "$1/.envrc"
	    fi
            echo "Flytter $1 til 4-arkiv"
            mv -i "$1" ~/Documents/4-arkiv/ # -i so asks before overwrite
        else
            echo "Error: $1 doesn't exist"
        fi
    else
        echo "Wrong number of arguments ($#)"
    fi
}

function indbakke() {
    if [ $# -eq 1 ]; then
        if [ -e "$1" ]; then
            echo "Flytter $1 til 0-inbox"
            mv -i "$1" ~/Documents/0-inbox/ # -i so asks before overwrite
        else
            echo "Error: $1 doesn't exist"
        fi
    else
        echo "Wrong number of arguments ($#)"
    fi
}



function ind() {
    if [ $# -eq 1 ]; then
        if [ -e "$1" ]; then
            echo "Flytter $1 til 00.01-Indbakke"
            mv -i "$1" ~/Documents/00-09_Meta/00_System/00.01_Indbakke/ # -i so asks before overwrite
        else
            echo "Error: $1 doesn't exist"
        fi
    else
        echo "Wrong number of arguments ($#)"
    fi
}



function ark() {
    if [ $# -eq 1 ]; then
        if [ -e "$1" ]; then
	    if [ -e "$1/.direnv" ]; then
	      echo "Removing .direnv cache"
	      trash "$1/.direnv"
	      trash -f "$1/.envrc"
	    fi
            echo "Flytter $1 til 00.99-Arkiv"
            mv -i "$1" ~/Documents/00-09_Meta/00_System/00.99_Arkiv/ # -i so asks before overwrite
        else
            echo "Error: $1 doesn't exist"
        fi
    else
        echo "Wrong number of arguments ($#)"
    fi
}


function tester() {
  if [ $# -eq 1 ]; then
    if [ -e "$1/.direnv" ]; then
      echo "dirty"
    fi
  fi
}

# expand-multiple-dots.zsh, see 
# https://github.com/parkercoates/dotfiles/blob/main/.zsh/expand-multiple-dots.zsh
#
# Based on http://stackoverflow.com/a/41420448/4757
function expand-multiple-dots() {
    local MATCH
    if [[ $LBUFFER =~ '(^| )\.\.\.+' ]]; then
        LBUFFER=$LBUFFER:fs%\.\.\.%../..%
    fi
}


function expand-multiple-dots-then-expand-or-complete() {
    zle expand-multiple-dots
    zle expand-or-complete
}

function expand-multiple-dots-then-accept-line() {
    zle expand-multiple-dots
    zle accept-line
}



# Bind these functions to tab/enter
zle -N expand-multiple-dots
zle -N expand-multiple-dots-then-expand-or-complete
zle -N expand-multiple-dots-then-accept-line
bindkey '^I' expand-multiple-dots-then-expand-or-complete
bindkey '^M' expand-multiple-dots-then-accept-line


function tex-init() { 
   if [[ $# -ne 1 ]]; then
       echo "Available templates:"
       for template in ~/Documents/3-ressourcer/latex-templates/*.tex; do
           basename "$template" .tex
       done
       echo ""
       echo "Usage: tex-init <template_name>"
       echo "Example:"
       echo "input: tex-init code"
       echo "output: preamble.tex"
       return 1
   fi
   
   cp ~/Documents/3-ressourcer/latex-templates/"$1".tex "preamble.tex"
}


# yazi wrapper
function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		builtin cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}

function mvcd() {
    # Pass all of your parameters to "mv"
    mv "$@"

    # Shift down all positional parameters except the last one (which should be your destination)
    shift $(( $# - 1 ))

    if [[ -d "${1}" ]]; then
        # Change to your destination if it was a directory
        cd "${1}"

    else
        # Otherwise, assume the destination was a file name and extract its directory component
        cd "$(dirname "${1}")"
    fi
}

function cpcd() {
    # Pass all of your parameters to "mv"
    cp "$@"

    # Shift down all positional parameters except the last one (which should be your destination)
    shift $(( $# - 1 ))

    if [[ -d "${1}" ]]; then
        # Change to your destination if it was a directory
        cd "${1}"

    else
        # Otherwise, assume the destination was a file name and extract its directory component
        cd "$(dirname "${1}")"
    fi
}

# Open *detached* from terminal
function open() {
    case "$1" in
        *.pdf|*.ods)
            setsid xdg-open "$1" &>/dev/null
            ;;
        *)
            xdg-open "$1"
            ;;
    esac
}
function typdf() {
  # typst watch "main.typ" "$1.pdf" --open
  wezterm cli split-pane --bottom --cells 8 -- typst watch "main.typ" "$1.pdf" --open && wezterm cli activate-pane-direction Up
}

function typ() {
  # typst watch "main.typ" "$1" --open
  wezterm cli split-pane --bottom --cells 8 -- typst watch "main.typ" "$1" --open && wezterm cli activate-pane-direction Up
}


# Alternative to 'open'

### NOTE: Copilot answer about syntax
# Most zsh users prefer the simpler POSIX syntax (`name() { }`) for better compatibility and cleaner code. Unless you specifically need the automatic local variable scoping, the simpler syntax is generally preferred.
#
# For maximum portability across shells, `name() { }` is the recommended approach.
function zathura() {
    setsid zathura "$1" &>/dev/null
}

function jd() {
  # Empty input goes to root directory (/Documents)
  if [[ -z $1 ]]
  then
    cd ~/Documents
    return 0
  fi
  # Only allow numbers, or decimal-separated numbers
  if [[ ! $1 =~ ^[0-9.]+$ ]]; then
    echo "Wrong number-format"
    return 1
  fi
  local depth
  local name="*$1*"
  local first_digit=${1:0:1}
  if [[ $1 =~ ^[0-9]$ ]]
  then 
    depth=0
    name="${1}0*"
  elif [[ $1 == *.* ]]
  then
    depth=2
  else
    depth=1
  fi
  local result=$(find ~/Documents/$first_digit* -maxdepth $depth -mindepth $depth -name "$name" -type d)
  if [[ -z $result ]]; then
    echo "No directory found"
    return 1
  fi
  if [[ $(echo "$result" | wc -l) -gt 1 ]]; then
    echo "Match not unique:"
    echo "$result"
    return 1
  fi
  cd $result
}

# alias sd="cd \$(find * -type d | fzf)"

function sd() {
    RES=$(find * -maxdepth 0 -type d   | fzf --query=$1 -1 -0)
    if [[ ! -z $RES ]]; then
        cd $RES
    fi
}


# Open application separately from terminal
function sep(){
    ("$@" >/dev/null 2>&1 &)
    }

function reload() {
  source $ZDOTDIR/.zshrc
}
