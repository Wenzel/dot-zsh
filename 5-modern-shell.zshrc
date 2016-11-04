#-----------------------------------------------------------------------------
#                               ALIASES
#-----------------------------------------------------------------------------

# -v : be verbose about args
# -y : file descriptor -> path
# -yy : socket -> IP and port
# -s : strsize : prevent strace to abbreviate strings
alias strace='strace -v -y -yy -s 4096'
alias cp='cp -rv'
alias mkdir='mkdir -p'
# -C : turn on colorization always
alias tree='tree -C'
# -h : display size human readable format
alias ls='ls --color=always -h --group-directories-first'
# -E : extended grep
# -i : ignore case
# -s : silent about non existent/unreadable files
# -n : print line number
alias grep='grep -E --color=always -i -n'
alias scp='scp -r'
alias rm='rm -rf --preserve-root'
alias wget='wget --continue'
# -N : non compatible mode
alias vim='vim -N'
# -x : print log level for each message
# --time-format ctime : print human readable time format
alias dmesg='dmesg --color=always -x --time-format ctime'
# -q : silent !
alias gdb='gdb -q'
# -a : all entries, not only directories
alias du='du -ah'

# GENERAL
alias ll='ls -l --group-directories-first'
alias la='ls -a --group-directories-first'
alias l='ls -l'
alias ..='cd ..'
alias brc='vim ~/.bashrc'
alias sbrc='source ~/.bashrc'
alias zrc='vim ~/.zshrc'
alias szrc='source ~/.zshrc'
alias quickrsync='rsync -azvhP --delete'
alias net='ping google.fr'
alias df='df -ah'
alias cswap='sudo /sbin/swapoff -a && sudo /sbin/swapon -a'
alias egrep='egrep --color=auto -i -n'
alias fgrep='fgrep --color=auto -i -n'
alias log='sudo journalctl -f'
alias logk='dmesg -w'
alias convname='convmv -f iso-8859-7 -t utf8 -r --notest --replace'
alias check_suid='find / -type f \( -perm -04000 -o -perm -02000 \)'
alias tmpdir='cd `mktemp -d`'
alias shred='shred -f -n 1 -u -v -z'
alias dmesg='dmesg -L'
alias nw.capture_dns="sudo tshark -i enp4s0 -n -f 'dst port 53'"
alias diff='colordiff'
alias mount='mount |column -t'
alias j='jobs -l'/rm
alias meminfo='free -m -l -t'
alias psmem='ps auxf | sort -nr -k 4'
alias pscpu='ps auxf | sort -nr -k 3'


# WEB
alias aspire='wget -r -k -np'

# PROGRAMMING
alias e='vim'
alias v='vim'
alias vrc='vim ~/.vimrc'
alias valgrind='valgrind -v --leak-check=full --show-reachable=yes --track-fds=yes --track-origins=yes --malloc-fill=42 --free-fill=43'
alias cmake_debug='cmake --debug-output --trace --warn-uninitialized --warn-unused-vars --check-system-vars'

# Socket
alias socket.unix='netstat -px'
alias socket.tcp='netstat -pt'
alias socket.udp='netstat -pu'
alias socket.raw='netstat -pw'
alias socket.multicast='netstat -g'
alias net.test.http="wget 'google.com' -O /dev/null > /dev/null"
alias net.test.ping='ping -c1 google.com'

# Git
alias glog="git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"
alias gl="git log --graph --oneline"
alias ga='git add'
alias gc='git commit -v'
alias gs='git status'
alias gp='git push'
alias gpu='git pull'
alias go='git checkout'
alias gls='git ls-files'
alias gb='git branch'
alias gdt='git difftool'
alias gd='git diff'
alias grb='git rebase'

# docker
alias dki='docker images'
alias dk.last='docker ps -l -q'
alias dk.clear.containers='docker rm $(docker ps -a -q)'
alias dk.clear.images='docker rmi $(docker images -q)'
alias dk.run='docker run -ti'
alias dk.run.gui='docker run -ti -e DISPLAY=$DISPLAY -v /tmp/.X11-unix:/tmp/.X11-unix:ro'
alias dk.runonce='docker run -ti --rm=true '
alias dk.runonce.gui='docker run -ti --rm=true -e DISPLAY=$DISPLAY -v /tmp/.X11-unix:/tmp/.X11-unix:ro'
alias dk.run.x='docker run -ti -v /tmp/.X11-unix:/tmp/.X11-unix'
alias dk.start='docker start -ai'

# Package Management
#--------------------------
# Systemd
#--------------------------
alias sysd.list='sudo systemctl list-unit-files'


#-----------------------------------------------------------------------------
#                               FUNCTIONS
#-----------------------------------------------------------------------------
quickchroot ()
{
    if [ $# -ne 1 ]; then
        echo "pas assez d'arguments"
    else
        mount -t proc none $1/proc
        mount --rbind /sys $1/sys
        mount --rbind /dev $1/dev
        chroot $1 /bin/bash
    fi
}

ntp.force-update ()
{
    sudo systemctl stop ntp.service
    sudo ntpdate 0.fr.pool.ntp.org
    sudo systemctl start ntp.service
    sudo hwclock --systohc
}

shred_dir ()
{
    if [ $# -lt 1 ]; then
        echo "shred_dir dir_path"
    else
        dir_path=$1
        find "$1" -type f -exec shred -f -n 1 -u -v -z {} \; && rm -rf $dir_path
    fi
}

gen_good_password ()
{
    len=$1
    pwgen -c -n -y -B $len 1
}
