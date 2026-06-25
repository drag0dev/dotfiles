# Nushell Environment Config File

def create_left_prompt [] {
    let home = ($env | get -i (if $nu.os-info.name == "windows" { "USERPROFILE" } else { "HOME" }) | into string)
    let dir = ([
        ($env.PWD | str substring 0..($home | str length) | str replace $home "~"),
        ($env.PWD | str substring ($home | str length)..)
    ] | str join)

    let branch = (gstat).branch
    let gitprompt = (if $branch == "no_branch" { "" } else { ["git:(", $branch, ")"] | str join })

    let path_segment = if (is-admin) {
        $"(ansi red_bold)($dir) (ansi blue)($gitprompt)"
    } else {
        $"(ansi light_cyan)($dir) (ansi red)($gitprompt)"
    }

    $path_segment
}

def create_right_prompt [] {
}

# Use nushell functions to define your right and left prompt
# $env.PROMPT_COMMAND = { nu /home/drago/nu_plugins/oh-my.nu }
$env.PROMPT_COMMAND = { create_left_prompt }
$env.PROMPT_COMMAND_RIGHT = { create_right_prompt }

# The prompt indicators are environmental variables that represent
# the state of the prompt
$env.PROMPT_INDICATOR = { "> " }
$env.PROMPT_INDICATOR_VI_INSERT = { ": " }
$env.PROMPT_INDICATOR_VI_NORMAL = { "> " }
$env.PROMPT_MULTILINE_INDICATOR = { "::: " }

# Specifies how environment variables are:
# - converted from a string to a value on Nushell startup (from_string)
# - converted from a value back to a string when running external commands (to_string)
# Note: The conversions happen *after* config.nu is loaded
$env.ENV_CONVERSIONS = {
  "PATH": {
    from_string: { |s| $s | split row (char esep) | path expand -n }
    to_string: { |v| $v | path expand -n | str join (char esep) }
  }
  "Path": {
    from_string: { |s| $s | split row (char esep) | path expand -n }
    to_string: { |v| $v | path expand -n | str join (char esep) }
  }
}

# Directories to search for scripts when calling source or use
#
# By default, <nushell-config-dir>/scripts is added
$env.NU_LIB_DIRS = [
    ($nu.config-path | path dirname | path join 'scripts')
]

# Directories to search for plugin binaries when calling register
#
# By default, <nushell-config-dir>/plugins is added
$env.NU_PLUGIN_DIRS = [
    ($nu.config-path | path dirname | path join 'plugins')
]

# To add entries to PATH (on Windows you might use Path), you can use the following pattern:
# $env.PATH = ($env.PATH | split row (char esep) | prepend '/some/path')

# =============================================================================
#
# Hook configuration for zoxide.
#

# Initialize hook to add new entries to the database.
if (not ($env | default false __zoxide_hooked | get __zoxide_hooked)) {
  $env.__zoxide_hooked = true
  $env.config = ($env | default {} config).config
  $env.config = ($env.config | default {} hooks)
  $env.config = ($env.config | update hooks ($env.config.hooks | default {} env_change))
  $env.config = ($env.config | update hooks.env_change ($env.config.hooks.env_change | default [] PWD))
  $env.config = ($env.config | update hooks.env_change.PWD ($env.config.hooks.env_change.PWD | append {|_, dir|
    zoxide add -- $dir
  }))
}

# =============================================================================
#
# When using zoxide with --no-cmd, alias these internal functions as desired.
#

# Jump to a directory using only keywords.
def --env __zoxide_z [...rest:string] {
  let arg0 = ($rest | append '~').0
  let path = if (($rest | length) <= 1) and ($arg0 == '-' or ($arg0 | path expand | path type) == dir) {
    $arg0
  } else {
    (zoxide query --exclude $env.PWD -- ...$rest | str trim -r -c "\n")
  }
  cd $path
}

# Jump to a directory using interactive search.
def --env __zoxide_zi [...rest:string] {
  cd $'(zoxide query --interactive -- ...$rest | str trim -r -c "\n")'
}

# =============================================================================
#
# Commands for zoxide. Disable these using --no-cmd.
#

alias z = __zoxide_z
alias zi = __zoxide_zi
