#
# ~/.bashrc
#

[[ $- != *i* ]] && return   # If not running interactively, don't do anything
[[ "$(whoami)" = "root" ]] && return    # If user is root, don't do anything
[[ -z "$FUNCNEST" ]] && export FUNCNEST=100          # limits recursive functions, see 'man bash'source ~/.bash_functions

source ~/.bash_prompt       # Set up the Terminal promt
source ~/.bash_functions    # Functions
source ~/.bash_alias        # Aliases
source ~/.bash_env          # Set environment variables
source ~/.bash_inputrc      # Bind input keys and set autocomplete options
