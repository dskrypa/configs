bashrc_user="dougs"  # More useful in envs where impersonating a machine user is common

# General
export PATH=$PATH:~/bin:~/sbin/ffmpeg/bin:~/sbin/ffmpeg/lib:~/sbin:"C:\\Program Files\\Graphviz\\bin"
export LS_COLORS="di=1;33:fi=0;0:ln=1;36:or=0;36;41:mi=0;31;46:ex=0;32"  # Linux, Windows
# export LSCOLORS="Dxfxcxdxbxegedabagacad"     # FreeBSD equivalent
# Order: dir, symlink, socket, pipe, exec, block special, char special, exec with setuid, exec with setguid, dir writable to others with sticky bit, dir writable to others without sticky bit

alias rgrep="grep -nriI"
alias grepg="egrep -nria --exclude-dir={.git,.idea,venv,venv_3.8,__pycache__,docs} --exclude={*.pyc,*.pyd,*.obj,*.pickle,*.doctree,*.xz,*.zip,*.7z,*.gz,*.rar,*.dll,.coverage}"
alias grepgc="egrep -nra --exclude-dir={.git,.idea,venv,venv_3.8,__pycache__,docs} --exclude={*.pyc,*.pyd,*.obj,*.pickle,*.doctree,*.xz,*.zip,*.7z,*.gz,*.rar,*.dll,.coverage}"

alias ls="ls --color"
alias vi="vim"
alias lst="ls -alh --time-style=long-iso"
alias cdiff="diff --old-group-format=$'%df-%dl Removed:\n\e[0;31m%<\e[0m' --new-group-format=$'%df-%dl Added:\n\e[0;32m%>\e[0m' --unchanged-group-format= -ts"
alias which="(alias; declare -f) | /usr/bin/which --tty-only --read-alias --read-functions --show-tilde --show-dot"
alias unexport=unset  # Because I always forget
alias trim='sed -r "s/^\s*(\S+(\s+\S+)*)\s*$/\1/"'


# Git
alias git_hist="git log --decorate"
alias git_unstage="git reset --"
alias gs="git status"
alias ga="git add"
alias gd="git diff"


# Python / venvs
export PYTHONIOENCODING=UTF-8
export PYTHONUTF8=1

export ARGCOMPLETE_USE_TEMPFILES=1
source ~/.config/bash_completion.d/python-argcomplete

alias activate=". venv/Scripts/activate"  # Windows
# alias activate=". venv/bin/activate"  # Linux
alias update_pip="python -m pip install --upgrade pip"
alias prep_venv="python -m pip install --upgrade pip && pip install wheel && pip install setuptools -U"
alias pip_update_all='pip install $(pip freeze | grep -v "@" | awk -F= "{print $1}") -U'

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


# Misc Programming
alias luai="lua51 -i ~/bin/init_env.lua"
alias dumpbin="/c/Program Files (x86)/Microsoft Visual Studio/2019/BuildTools/VC/Tools/MSVC/14.26.28801/bin/Hostx64/x64/dumpbin.exe"


# Windows-specific
alias traceroute=tracert  # tracert is the Windows equivalent


# Functions
function set_title() { printf "\033]0;%s\a" $1; }
function set_cmd_title() { cmd=( $BASH_COMMAND ); echo -ne "\033]0;${cmd[0]}\a"; }


# History
export HISTSIZE=-1                  # Remove history size limit (in memory)
export HISTFILESIZE=-1              # Remove history size limit (on disk)
export PROMPT_COMMAND="history -a"  # Commit history to disk after each command
# export PROMPT_COMMAND="history -a; set_title $HOSTNAME"  # Commit history to disk after each command & reset title

if [ "$(whoami)" == "$bashrc_user" ]; then
    # Note: In envs where a single session at a time is more likely, and extended history is desired, then commenting
    # out this section may be preferable to use the single ~/.bash_history instead.
    if [ ! -d ~/.history ] && [ ! -e ~/.history ]; then
        mkdir ~/.history
        chmod 700 ~/.history
    fi
    suffix=`tty | cut -d"/" -f3- | sed -e s/"\/"/_/g`
    HISTFILE=~/.history/`date +%Y-%m-%d`.${suffix}
fi
if [ -n "$HISTFILE" ]; then
    short_hist=$(basename $HISTFILE)
    short_hist=${short_hist#*ory.}
fi


# Prompt
Red=$'\e[1;31m'
Yellow=$'\e[1;33m'
Cyan=$'\e[1;36m'
Green=$'\e[1;32m'
Reset=$'\e[1;0m'
export PS1="\[$Yellow\][\t]\[$Green\]\u\[$Reset\]@\[$Cyan\]\H\[$Reset\]: \[$Yellow\]\w \[$Green\]\!\[$Yellow\]\$\[\e[m\] "


# Bash options
shopt -s histappend
shopt -s checkhash
shopt -s checkwinsize
shopt -s cmdhist
shopt -s no_empty_cmd_completion
# trap 'set_cmd_title' DEBUG

#Set this last, as afterwards, everything else goes into history - it should be the LAST entry in .bashrc
set -o history
