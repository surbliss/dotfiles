
# JJ prompt equivalent to your git prompt
# Add this to your .zshrc

jj_super_status() {
  if ! command -v jj >/dev/null 2>&1; then
    return 1
  fi
  
  # Check if we're in a jj repo
  if ! jj root >/dev/null 2>&1; then
    return 1
  fi
  
  local jj_status=""
  local prefix=""
  local suffix=" "
  local separator=" "
  
  # Get current branch/change info
  local current_change=$(jj log -r @ --no-graph -T 'change_id.short()' 2>/dev/null)
  local branch_info=$(jj branch list --mine -T 'name' 2>/dev/null | head -n1)
  
  if [[ -n "$branch_info" ]]; then
    jj_status+="%F{#d891ef} %B${branch_info}%b%f"
  else
    jj_status+="%F{#d891ef} %B${current_change}%b%f"
  fi
  
  # Check for conflicts
  if jj log -r @ -T 'if(conflict, "conflict", "")' 2>/dev/null | grep -q "conflict"; then
    jj_status+="%{$fg_bold[red]%}✖%{$reset_color%}"
  fi
  
  # Check working copy status
  local status_output=$(jj status --no-pager 2>/dev/null)
  local has_changes=false
  
  # Check for modified files
  if echo "$status_output" | grep -q "^M "; then
    jj_status+="%{$fg_bold[red]%}*%{$reset_color%}"
    has_changes=true
  fi
  
  # Check for added files  
  if echo "$status_output" | grep -q "^A "; then
    jj_status+="%{$fg_bold[red]%}+%{$reset_color%}"
    has_changes=true
  fi
  
  # Check for deleted files
  if echo "$status_output" | grep -q "^D "; then
    jj_status+="%{$fg_bold[red]%}-%{$reset_color%}"
    has_changes=true
  fi
  
  # Check for unknown files (untracked)
  if echo "$status_output" | grep -q "^? "; then
    jj_status+="%{$fg_bold[red]%}?%{$reset_color%}"
    has_changes=true
  fi
  
  # If no changes, show clean status
  if [[ "$has_changes" == "false" ]]; then
    jj_status+="%{$fg_bold[green]%}✔%{$reset_color%}"
  fi
  
  echo "${prefix}${jj_status}${suffix}"
}

# Modified prompt that works with both git and jj
# Replace your PROMPT line with this:
PROMPT='$SHELL_PROMPT$PROMPT_DIR$(git_super_status)$(jj_super_status)$BACKGROUND_PROCESSES$PROMPT_SEP'
