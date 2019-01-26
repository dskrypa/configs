bashrc_user="dougs"

alias luai="lua51 -i ~/bin/init_env.lua"
alias rgrep="grep -nriI"
alias grepg="grep -nria --exclude-dir=.git --exclude-dir=.idea --exclude=*.pyc"
alias git_hist="git log --decorate"
alias cdiff="diff --old-group-format=$'%df-%dl Removed:\n\e[0;31m%<\e[0m' --new-group-format=$'%df-%dl Added:\n\e[0;32m%>\e[0m' --unchanged-group-format= -ts"
alias lst="ls -alh --time-style=long-iso"
alias gen_reqs='pip3 freeze | egrep -iv "backcall|jedi|ipython|decorator|traitlets|prompt-toolkit|pygments|pickleshare|colorama|parso" | sed "s/==/>=/" | dos2unix'

which () {
    (alias; declare -f) | /usr/bin/which --tty-only --read-alias --read-functions --show-tilde --show-dot $@
}

if [ "$(whoami)" == "$bashrc_user" ]; then
    if [ ! -d ~/.history ] && [ ! -e ~/.history ]; then
        mkdir ~/.history
        chmod 600 ~/.history
    fi
    suffix=`tty | cut -d"/" -f3- | sed -e s/"\/"/_/g`
    HISTFILE=~/.history/`date +%Y-%m-%d`.${suffix}
fi
if [ -n "$HISTFILE" ]; then
    short_hist=$(basename $HISTFILE)
    shirt_hist=${short_hist#*ory.}
fi


Yellow=$'\e[1;33m'
Reset=$'\e[1;0m'
Cyan=$'\e[1;36m'
Green=$'\e[1;32m'

export PS1="\[$Yellow\][\t]\[$Green\]\u\[$Reset\]@\[$Cyan\]\H\[$Reset\]: \[$Yellow\]\w \[$Green\]\!\[$Yellow\]\$\[\e[m\] "

export LS_COLORS="di=1;33:fi=0;0:ln=1;36:or=0;36;41:mi=0;31;46:ex=0;32"
alias ls="ls --color"
alias vi="vim"

shopt -s histappend
shopt -s checkhash
shopt -s checkwinsize
shopt -s cmdhist
shopt -s no_empty_cmd_completion

export PATH=$PATH:~/bin

#Set this last, as afterwards, everything else goes into history - it should be the LAST entry in .bashrc
set -o history
