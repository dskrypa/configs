bashrc_user="dougs"

alias rgrep="grep -nriI"
alias grepg="egrep -nria --exclude-dir=.git --exclude-dir=.idea --exclude=*.pyc --exclude=*.pyd --exclude=*.obj --exclude-dir=venv --exclude-dir=venv_3.8 --exclude-dir=__pycache__ --exclude-dir=docs --exclude=*.pickle --exclude=*.doctree --exclude=*.xz --exclude=*.zip --exclude=*.7z --exclude=*.gz --exclude=*.rar --exclude=*.dll"
alias grepgc="egrep -nra --exclude-dir=.git --exclude-dir=.idea --exclude=*.pyc --exclude=*.pyd --exclude=*.obj --exclude-dir=venv --exclude-dir=venv_3.8 --exclude-dir=__pycache__"

alias cdiff="diff --old-group-format=$'%df-%dl Removed:\n\e[0;31m%<\e[0m' --new-group-format=$'%df-%dl Added:\n\e[0;32m%>\e[0m' --unchanged-group-format= -ts"
alias lst="ls -alh --time-style=long-iso"

alias git_hist="git log --decorate"
alias git_unstage="git reset --"
alias gs="git status"
alias ga="git add"
alias gd="git diff"

alias activate=". venv/Scripts/activate"
alias update_pip="python -m pip install --upgrade pip"
alias prep_venv="python -m pip install --upgrade pip && pip install wheel && pip install setuptools -U"
alias update_dbcache="pip install git+git://github.com/dskrypa/db_cache"
alias update_dstools="pip install git+git://github.com/dskrypa/ds_tools"
alias update_reqclient="pip install git+git://github.com/dskrypa/requests_client"
alias update_tzdt="pip install git+git://github.com/dskrypa/tz_aware_dt"
alias update_wikinodes="pip install git+git://github.com/dskrypa/wiki_nodes"
alias update_pypod="pip install git+git://github.com/dskrypa/pypod"
alias ipy3wiki="ipython -ic 'from music.wiki import *'"
alias ipy3nodes="ipython -ic 'from wiki_nodes import *'"

alias gen_reqs='pip3 freeze | egrep -iv "backcall|jedi|ipython|decorator|traitlets|prompt-toolkit|pygments|pickleshare|colorama|parso|pipdeptree" | sed "s/==/>=/" | dos2unix'
alias gen_reqs_no_acoustid='pip3 freeze | egrep -iv "backcall|jedi|ipython|decorator|traitlets|prompt-toolkit|pygments|pickleshare|colorama|parso|pipdeptree|pyacoustid|audioread" | sed "s/==/>=/" | dos2unix'

alias luai="lua51 -i ~/bin/init_env.lua"

alias traceroute=tracert

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

export ARGCOMPLETE_USE_TEMPFILES=1
source ~/.config/bash_completion.d/python-argcomplete


Yellow=$'\e[1;33m'
Reset=$'\e[1;0m'
Cyan=$'\e[1;36m'
Green=$'\e[1;32m'

export PS1="\[$Yellow\][\t]\[$Green\]\u\[$Reset\]@\[$Cyan\]\H\[$Reset\]: \[$Yellow\]\w \[$Green\]\!\[$Yellow\]\$\[\e[m\] "

export LS_COLORS="di=1;33:fi=0;0:ln=1;36:or=0;36;41:mi=0;31;46:ex=0;32"
#export LSCOLORS="Dxfxcxdxbxegedabagacad"     # FreeBSD equivalent
# Order: dir, symlink, socket, pipe, exec, block special, char special, exec with setuid, exec with setguid, dir writable to others with sticky bit, dir writable to others without sticky bit
alias ls="ls --color"
alias vi="vim"

shopt -s histappend
shopt -s checkhash
shopt -s checkwinsize
shopt -s cmdhist
shopt -s no_empty_cmd_completion

export PATH=$PATH:~/bin:~/sbin/ffmpeg/bin:~/sbin/ffmpeg/lib:~/sbin
#export PATH=$PATH:~/bin:C:\\Users\\dougs\\sbin\\ffmpeg:C:\\Users\\dougs\\sbin\\ffmpeg\\bin:C:\\Users\\dougs\\sbin\\ffmpeg\\lib:C:\\Users\\dougs\\sbin\\ffmpeg\\include
export PYTHONIOENCODING=utf-8

#Set this last, as afterwards, everything else goes into history - it should be the LAST entry in .bashrc
set -o history
