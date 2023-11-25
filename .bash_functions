#!/bin/bash
# This function came with EOS and I am not sure what this does
#_set_liveuser_PS1() {
#    PS1='[\u@\h \W]\$ '
#    if [ "$(whoami)" = "liveuser" ] ; then
#        local iso_version="$(grep ^VERSION= /usr/lib/endeavouros-release 2>/dev/null | cut -d '=' -f 2)"
#        if [ -n "$iso_version" ] ; then
#            local prefix="eos-"
#            local iso_info="$prefix$iso_version"
#            PS1="[\u@$iso_info \W]\$ "
#        fi
#    fi
#}
#_set_liveuser_PS1
#unset -f _set_liveuser_PS1
# This function came with EOS and reports the version of EOS that was originally installed
ShowInstallerIsoInfo() {
    local file=/usr/lib/endeavouros-release
    if [ -r $file ] ; then
        cat $file
    else
        echo "Sorry, installer ISO info is not available." >&2
    fi
}

# This function came with EOS and opens a text file for editing from the commmand line
_open_files_for_editing() {
    # Open any given document file(s) for editing (or just viewing).
    # Note1:
    #    - Do not use for executable files!
    # Note2:
    #    - Uses 'mime' bindings, so you may need to use
    #      e.g. a file manager to make proper file bindings.

    if [ -x /usr/bin/exo-open ] ; then
        echo "exo-open $@" >&2
        setsid exo-open "$@" >& /dev/null
        return
    fi
    if [ -x /usr/bin/xdg-open ] ; then
        for file in "$@" ; do
            echo "xdg-open $file" >&2
            setsid xdg-open "$file" >& /dev/null
        done
        return
    fi

    echo "$FUNCNAME: package 'xdg-utils' or 'exo' is required." >&2
}
#------------------------------------------------------------
# alias ef='_open_files_for_editing'     # 'ef' opens given file(s) for editing
################################################################################

# Reference the Cheat Sheet web page for a command for a TLDR help reference
cs() { curl -m 7 "http://cheat.sh/$1"; }

# Runs a program without displaying output on stdout or stderr
run() { "$1" &>/dev/null & }

# Checks to see if a package is installed or not
havei() {
  package=$1
  # The if statement returns 0 if the pacman command was successful and 1 if an error codition occurs (ie. no package)
  if $(pacman -Qi $package &>/dev/null)
  then
    echo -e "\e[92m[ 🗸 ] $package is installed \e[39m"
    true    # The package was found (pacman successfully executed)
  else
    echo -e "\e[91m[ X ] $package is not installed \e[39m"
    false   # The package was not found (pacman returned an error condition)
  fi
}
