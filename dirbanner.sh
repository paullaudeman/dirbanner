# dirbanner ~ print a per-directory banner on entry.
# Source this from your ~/.zshrc (the install script does it for you):
#     source /path/to/dirbanner.sh
#
# Drop a file named `.dirbanner` in any directory and it prints whenever you
# `cd` into that directory. Put raw ANSI escape codes in it for color ~ the
# function just `cat`s the file, so whatever bytes are in there hit the terminal.

_dirbanner() {
  [ -r .dirbanner ] && cat .dirbanner
}

# zsh: hook into directory changes
if [ -n "$ZSH_VERSION" ]; then
  autoload -Uz add-zsh-hook 2>/dev/null
  add-zsh-hook chpwd _dirbanner 2>/dev/null
  # also fire when a shell starts already inside a bannered directory
  _dirbanner

# bash: emulate chpwd via PROMPT_COMMAND, only firing when the directory changes
elif [ -n "$BASH_VERSION" ]; then
  _dirbanner_last="$PWD"
  _dirbanner_check() {
    if [ "$PWD" != "$_dirbanner_last" ]; then
      _dirbanner_last="$PWD"
      _dirbanner
    fi
  }
  case "$PROMPT_COMMAND" in
    *_dirbanner_check*) ;;
    *) PROMPT_COMMAND="_dirbanner_check${PROMPT_COMMAND:+; $PROMPT_COMMAND}" ;;
  esac
  _dirbanner
fi
