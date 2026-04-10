# env.nu
#
# Installed by:
# version = "0.105.1"
#
# Previously, environment variables were typically configured in `env.nu`.
# In general, most configuration can and should be performed in `config.nu`
# or one of the autoload directories.
#
# This file is generated for backwards compatibility for now.
# It is loaded before config.nu and login.nu
#
# See https://www.nushell.sh/book/configuration.html
#
# Also see `help config env` for more options.
#
# You can remove these comments if you want or leave
# them for future reference.


## ${UserConfigDir}/nushell/env.nu
$env.CARAPACE_BRIDGES = 'zsh,fish,bash,inshellisense' # optional
mkdir $"($nu.cache-dir)"
carapace _carapace nushell | save --force $"($nu.cache-dir)/carapace.nu"



# Should be at the end of env.nu
zoxide init nushell --cmd j | save -f ($nu.default-config-dir | path join zoxide.nu)

jj util completion nushell |
   save -f ($nu.default-config-dir | path join completions-jj.nu)

