# title           : ls/aliases.zsh
# description     : This file provides various aliases to the ls command.
# date            : 2019-04-30
# dependencies    : -
# zsh_version     : 5.7.1
# ====================================================================================


# use colors if possible and a custom time stamp format
alias ls='ls --color=auto --time-style=+"%Y-%m-%d %H:%M:%S" --group-directories-first'
alias la='ls -A'                            # list all files (including hidden ons, excluding . and ..)
alias l.='ls -Ad .?*'                       # list hidden files only
alias l='ls -lAh'                           # list all files with details
alias ll='ls -lh'                           # list non-hidden files with details
alias lp='ls -d "$(pwd)"/*'                 # list non-hidden files with full path
alias lr='ls -lRh'                          # list non-hidden files recursively
alias lt='ls -Alht'                         # list all files sorted by time (newest first)
alias ltr='ls -Alhtr'                       # list all files sorted by time (oldest first)
alias lss='ls -AlhS'                        # list all files sorted by size (biggest first)
alias lssr='ls -AlhSr'                      # list all files sorted by size (smallest first)

# color output if possible and change time stamp to (e.g.): 2019-03-05 18:48:51
# TODO: testing
if [[ "$(uname 2> /dev/null)" == 'Darwin' ]]; then
  alias ls='gls --color'
fi