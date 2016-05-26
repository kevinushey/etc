# -*- tab-width: 4, indent-tabs-mode: t -*-

## Generic
joined () {

	if [ "$#" -le 1 ]; then
		echo "Usage: joined delimiter [values...]"
		return 1
	fi

	OLD_IFS_="${IFS}"
	IFS="$1"
	shift
	echo "$*"
	IFS="${OLD_IFS_}"
}

defvar () {

	if test "$#" -eq 0; then
		echo "Usage: defvar [variable value]+"
		return 1
	fi

	while test "$#" -ge 2; do
		eval "$1='$2'" && export "$1"
		shift 2
	done

}

defjoined () {

	if [ "$#" -le 2 ]; then
		echo "Usage: defjoined variable delimiter [values...]"
		return 1
	fi

	DEFJOINED_VARIABLE_="$1"
	shift
	defvar "${DEFJOINED_VARIABLE_}" `joined "$@"`
	unset DEFJOINED_VARIABLE_
}

rot13 () {
	echo "$@" | tr "[A-Za-z]" "[N-ZA-Mn-za-m]"
}

replace () {

	if [ "$#" -ne 2 ]; then
		echo "Usage: replace from to";
		return 1
	fi

	find . -type f -not -path '*/\.*' -exec perl -pi -e "s|\Q$1\E|$2|g" {} +

}

hascmd () {

	if [ "$#" -ne 1 ]; then
		echo "Usage: hascmd command"
		return 1
	fi

	command -v "$1" > /dev/null 2>&1
}

# Navigate up a number of directories.
up () {

	if [ "$#" -eq 0 ]; then
		echo "Usage: up n"
		return 1
	fi

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

# Go to the directory for the first file with some name.
goto () {

	if [ "$#" -eq 0 ]; then
		echo "Usage: goto file"
		return 1
	fi

	cd `ag -g $1 | head -n 1 | xargs dirname`
}

# Use ffpmeg to quickly convert a .mov to a .gif.
# Primarily used for quickly converting screencasts
# into gifs (which can then be viewed online easily)
mov2gif () {

	if [ "$#" -eq 0 ]; then
		echo "Usage: mov2gif input [output]"
		return 1
	fi

	if test "$#" -eq 1; then
		OUTPUT="$1"
		OUTPUT="${OUTPUT%.mov}".gif
	else
		OUTPUT="$2"
	fi

	ffmpeg -i "$1" -r 20 -f image2pipe -vcodec ppm - | \
		convert -delay 5 -fuzz 2% -layers Optimize -loop 0 - "${OUTPUT}"
}

## Emacs

e () {
	if test "$#" -eq 0; then
		ALTERNATE_EDITOR= emacsclient -t .
	else
		ALTERNATE_EDITOR= emacsclient -t "$@"
	fi
}

# Open a file using emacsclient.
#
# I wasted way too much time making this work, but apparently
# emacsclient doesn't allow e.g.
#
#    emacsclient file.txt -c -e "(print \"Sucker\")"
#
# so I ended up pasting the file visiting into the eval statement.
ec () {

	if test "$#" -ge 1; then

		read -r -d '' EMACSCLIENT_EVAL <<- EOM
		(progn
			(select-frame-set-input-focus (selected-frame))
			(set-frame-font "Droid Sans Mono-14" nil t)
			(find-file "$1")
		)
		EOM

		shift

	else

		read -r -d '' EMACSCLIENT_EVAL <<- EOM
		(progn
			(select-frame-set-input-focus (selected-frame))
			(set-frame-font "Droid Sans Mono-14" nil t)
		)
		EOM

	fi

	ALTERNATE_EDITOR= emacsclient \
					--create-frame \
					--eval "${EMACSCLIENT_EVAL}"

}

b64encode () {
	openssl base64 -in $1 | tr -d '\n'
}

dock () {
	docker-machine start docker-dev
	eval $(docker-machine env docker-dev)
}

if [ -n "${IS_DARWIN}" ]; then

	Emacs () {
		"/Applications/Emacs.app/Contents/MacOS/Emacs" $@ &
	}

	# Quickly switch between multiple versions of R.
	rswitch () {

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
	# Launch the development version of RStudio. Presumes that
	# it's been built in 'git/rstudio/src/xcode-build'.
	rstudiodev () {
		OWD="$(pwd)"
		cd ~/git/rstudio/src/xcode-build
		./desktop-mac/Debug/RStudio.app/Contents/MacOS/RStudio "$@" &
		cd $OWD
	}

fi

