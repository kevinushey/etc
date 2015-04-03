if [ "$(uname)" = "Darwin" ]; then
  export IS_DARWIN=1
elif [ "$(uname)" = "Linux" ]; then
  export IS_LINUX=1
fi

if [ command -v lsb_release 2> /dev/null ]; then
  export DISTRO="$(lsb_release -i | cut -d: -f2 | sed s/^\t//)"
	if [ "${DISTRO}" = "Ubuntu" ]; then
		export IS_UBUNTU=1
	fi
fi

color_prompt=yes
force_color_prompt=yes

# Ask R to kindly keep debugging symbols
PKG_MAKE_DYM=yes

PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/sbin/opt/X11/bin:/usr/texbin" 

## Colors
if [ -n "${IS_DARWIN}" ]; then
  alias git=/usr/local/bin/git
fi

# Reset
Color_Off="\[\033[m\]"       # Text Reset

# Regular Colors
Black="\[\033[30m\]"        # Black
Red="\[\033[31m\]"          # Red
Green="\[\033[32m\]"        # Green
Yellow="\[\033[33m\]"       # Yellow
Blue="\[\033[34m\]"         # Blue
Purple="\[\033[35m\]"       # Purple
Cyan="\[\033[36m\]"         # Cyan
White="\[\033[37m\]"        # White

# Bold
BBlack="\[\033[30m\]"       # Black
BRed="\[\033[31m\]"         # Red
BGreen="\[\033[32m\]"       # Green
BYellow="\[\033[33m\]"      # Yellow
BBlue="\[\033[34m\]"        # Blue
BPurple="\[\033[35m\]"      # Purple
BCyan="\[\033[36m\]"        # Cyan
BWhite="\[\033[37m\]"       # White

# Underline
UBlack="\[\033[30m\]"       # Black
URed="\[\033[31m\]"         # Red
UGreen="\[\033[32m\]"       # Green
UYellow="\[\033[33m\]"      # Yellow
UBlue="\[\033[34m\]"        # Blue
UPurple="\[\033[35m\]"      # Purple
UCyan="\[\033[36m\]"        # Cyan
UWhite="\[\033[37m\]"       # White

# Background
On_Black="\[\033[40m\]"       # Black
On_Red="\[\033[41m\]"         # Red
On_Green="\[\033[42m\]"       # Green
On_Yellow="\[\033[43m\]"      # Yellow
On_Blue="\[\033[44m\]"        # Blue
On_Purple="\[\033[45m\]"      # Purple
On_Cyan="\[\033[46m\]"        # Cyan
On_White="\[\033[47m\]"       # White

# High Intensity
IBlack="\[\033[90m\]"       # Black
IRed="\[\033[91m\]"         # Red
IGreen="\[\033[92m\]"       # Green
IYellow="\[\033[93m\]"      # Yellow
IBlue="\[\033[94m\]"        # Blue
IPurple="\[\033[95m\]"      # Purple
ICyan="\[\033[96m\]"        # Cyan
IWhite="\[\033[97m\]"       # White

# Bold High Intensity
BIBlack="\[\033[90m\]"      # Black
BIRed="\[\033[91m\]"        # Red
BIGreen="\[\033[92m\]"      # Green
BIYellow="\[\033[93m\]"     # Yellow
BIBlue="\[\033[94m\]"       # Blue
BIPurple="\[\033[95m\]"     # Purple
BICyan="\[\033[96m\]"       # Cyan
BIWhite="\[\033[97m\]"      # White

# High Intensity backgrounds
On_IBlack="\[\033[100m\]"   # Black
On_IRed="\[\033[101m\]"     # Red
On_IGreen="\[\033[102m\]"   # Green
On_IYellow="\[\033[103m\]"  # Yellow
On_IBlue="\[\033[104m\]"    # Blue
On_IPurple="\[\033[105m\]"  # Purple
On_ICyan="\[\033[106m\]"    # Cyan
On_IWhite="\[\033[107m\]"   # White

export CCACHE_CPP2=yes

NODE_PATH="/usr/local/lib/node"
export PYTHONSTARTUP=".pythonstartup.py"
alias untar="tar -xvf"
export PATH
export EDITOR="vim"

alias rgrep="grep -r"

export CLICOLOR=1
export LSCOLORS=ExFxBxDxCxegedabagacad
if [ -n "${IS_DARWIN}" ]; then
    alias ll='ls -laGFh'
elif [ -n "${IS_LINUX}" ]; then
    alias ls='ls --color'
    alias ll='ls -laGFh --color'
fi

## silliness
NAME="Kevin"
NAME+=" "
NAME+="Ushey"
export NAME

EMAIL="kevin"
EMAIL+="ushey"
EMAIL+="@"
EMAIL+="gmail"
EMAIL+=".com"
export EMAIL

## Go
export GOPATH=~/goprojects
if [ -n "${IS_DARWIN}" ]; then
    export GOROOT=/usr/local/opt/go/libexec
fi

PATH=$PATH:$GOPATH/bin:$GOROOT/bin

export GNUTERM='x11'

if [ -n "${IS_DARWIN}" ]; then

  if [ -f $(brew --prefix)/etc/bash_completion ]; then
      . $(brew --prefix)/etc/bash_completion
  fi

  if [ -f $(brew --prefix)/etc/bash_completion.d ]; then
      . $(brew --prefix)/etc/bash_completion.d
  fi

  if [ -f ~/git-completion.bash ]; then
      source ~/git-completion.bash
  fi

fi

if [ -n "${IS_LINUX}" ]; then

    if [ ! -f ~/.git-completion.bash ]; then
        curl https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash -o ~/.git-completion.bash
    fi
    source ~/.git-completion.bash
fi

git_prompt ()
{
    GIT_STATUS=$(git status -sb --porcelain  2> /dev/null | head -n 1)

    if test -n "${GIT_STATUS}"
    then
      GIT_STATUS=$(echo "${GIT_STATUS}" | sed 's|## *||')
      GIT_START=$(echo "${GIT_STATUS}" | sed 's|\.\.\..*||g')
      if [[ "${GIT_START}" =~ "no branch" ]]; then
        GIT_START=$(git -c color.status=false status | head -n 1)
      fi
      echo -e " ${Red}[${GIT_START}]${Color_Off}"
    else
        echo ""
    fi
}

prompt_command () {
    GIT_PROMPT=$(git_prompt)
    # export PS1="\[\033[36m\]\u\[\033[m\]@\[\033[32m\]\h:\[\033[33;1m\]\w\[\033[m\]${GIT_PROMPT}\$ "
    export PS1="${Cyan}kevin:${Color_Off}${BYellow}\w${Color_Off}${GIT_PROMPT}\$ "
}

export PROMPT_COMMAND=prompt_command

alias R="R_GC_MEM_GROW=3 R --min-vsize=2048M --min-nsize=20M --no-restore"

sourceCpp () {
    Rscript -e "library(Rcpp); sourceCpp('$1', verbose=TRUE)"
}

sourceCpp11 () {
  Rscript -e "attributes::sourceCpp('$1')"
}

## Find and replace all non-dot files
replace () {

    if [ $# -ne 2 ]; then
        echo "Usage: replace (from) (to)";
        return 1
    fi

    find . -type f -not -path '*/\.*' -exec perl -pi -e "s|\Q$1\E|$2|g" {} +

}

testRcpp11 () {
  cd ~/git
  R CMD INSTALL Rcpp11
  R CMD INSTALL --preclean Rcpp-test
  R -e "library(Rcpp11); library(attributes); library(testthat); test_dir('Rcpp-test')"
}

Emacs()
{
  "/Applications/Emacs.app/Contents/MacOS/Emacs" $@ &
}

## Start emacs in daemon mode
alias e='emacsclient -t'
alias ec='emacsclient -c'

if [ -n "${IS_DARWIN}" ]; then

  rstudio-dev () {
      OWD="$(pwd)"
      cd ~/git/rstudio/src/xcode-build
      ./desktop-mac/Debug/RStudio.app/Contents/MacOS/RStudio &
      cd $OWD
  }

fi

export DOCKER_HOST=tcp://192.168.59.103:2376
export DOCKER_CERT_PATH=${HOME}/.boot2docker/certs/boot2docker-vm
export DOCKER_TLS_VERIFY=1

docker-clean () {
    docker ps -a -q | xargs docker kill | xargs docker rm
}

if [ -n "${IS_DARWIN}" ]; then

  function r-switch {

    if test "$#" -ne 1
    then
      echo "Usage: r-switch [R-version]; e.g. 'r-switch 3.1' to use R 3.1"
      return
    fi

    OWD=$(pwd)
    cd /Library/Frameworks/R.framework/Versions/
    sudo rm -f Current
    sudo ln -fs $1 Current
    cd ${OWD}
  }

fi

rci () {
    if test "$#" -eq 0; then
        R CMD INSTALL .
    else
        R CMD INSTALL "$@"
    fi
}

rcip () {
    if test "$#" -eq 0; then
        R CMD INSTALL --preclean .
    else
        R CMD INSTALL --preclean "$@"
    fi
}

vi () {
  vim -Nu ~/.vimrc.sensible $@
}

remove-trailing-newline () {
    perl -p -i -e 'chomp if eof' $@
}

sublime () {
    open /Applications/Sublime\ Text\ 2.app
}

up () {
    COUNT=1
    if test "$#" -eq 1
    then
        COUNT=$1
    fi

    for i in `seq 1 ${COUNT}`
    do
        cd ../
    done
}

mov2gif () {
    if test "$#" -eq 1; then
        OUTPUT=$1
        OUTPUT=${OUTPUT%.mov}.gif
    else
        OUTPUT=$2
    fi

    ffmpeg -i $1 -pix_fmt rgb24 -r 10 ${OUTPUT}
}

if [ -n "${IS_LINUX}" ]; then

    if [ -f ~/.bash_aliases ]; then
        . ~/.bash_aliases
    fi

    # enable programmable completion features (you don't need to enable
    # this, if it's already enabled in /etc/bash.bashrc and /etc/profile
    # sources /etc/bash.bashrc).
    if ! shopt -oq posix; then
        if [ -f /usr/share/bash-completion/bash_completion ]; then
            . /usr/share/bash-completion/bash_completion
        elif [ -f /etc/bash_completion ]; then
            . /etc/bash_completion
        fi
    fi

fi

goto-file () {
    cd `ag -g $1 | head -n 1 | xargs dirname`
}

rocker-test () {
  if test "$#" -ne 1; then
    echo "Usage: rocket-test [package-tarball]"
    return
  fi

  docker run --rm -it -v $(pwd):/mnt rocker/r-devel-ubsan-clang check.r --setwd /mnt --install-deps $1

}

increase-transparency () {
    convert $1 -alpha on -channel a -evaluate Divide 1.25 +channel $1
}

reduce-transparency () {
    convert $1 -alpha on -channel a -evaluate Divide 0.8 +channel $1
}

