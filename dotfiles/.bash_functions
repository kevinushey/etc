# -*- tab-width: 4, indent-tabs-mode: t -*-

## Generic
joined () {

	if [ "$#" -le 1 ]; then
		echo "Usage: joined [delimiter] [values...]"
		return 1
	fi

	local IFS="$1"
	shift
	echo "$*"
}

define () {

	if [ "$#" -ne 2 ]; then
		echo "Usage: define [variable] [value]"
		return 1
	fi

	export "$1"="$2"
}

define-joined () {

	if [ "$#" -le 2 ]; then
		echo "Usage: define-joined [variable] [delimiter] [values...]"
		return 1
	fi

	local VARIABLE="$1"
	shift
	export "$VARIABLE"=`joined "$@"`
}

rot13 () {
	echo "$@" | tr "[A-Za-z]" "[N-ZA-Mn-za-m]"
}

replace () {

	if [ "$#" -ne 2 ]; then
		echo "Usage: replace [from] [to]";
		return 1
	fi

	find . -type f -not -path '*/\.*' -exec perl -pi -e "s|\Q$1\E|$2|g" {} +

}

program-exists () {

	if [ "$#" -ne 1 ]; then
		echo "Usage: program-exists [program]"
		return 1
	fi

	command -v "$1" > /dev/null 2>&1
}

# This is a cool function because the flags passed to
# perl are 'pie' and we are 'chomp'ing.
remove-trailing-newline () {
	perl -p -i -e 'chomp if eof' "$@"
}

# Navigate up a number of directories.
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

# Go to the directory for the first file with some name.
goto-file () {
	cd `ag -g $1 | head -n 1 | xargs dirname`
}

# Use ffpmeg to quickly convert a .mov to a .gif.
# Primarily used for quickly converting screencasts
# into gifs (which can then be viewed online easily)
mov2gif () {

	if test "$#" -eq 1; then
		OUTPUT="$1"
		OUTPUT="${OUTPUT%.mov}".gif
	else
		OUTPUT="$2"
	fi

	ffmpeg -i "$1" -pix_fmt rgb24 -r 10 "${OUTPUT}"
}

## Emacs
increase-transparency () {
	convert "$1" -alpha on -channel a -evaluate Divide 1.25 +channel "$1"
}

reduce-transparency () {
	convert "$1" -alpha on -channel a -evaluate Divide 0.8 +channel "$1"
}

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


if [ -n "${IS_DARWIN}" ]; then

	Emacs () {
		"/Applications/Emacs.app/Contents/MacOS/Emacs" $@ &
	}

	# Quickly switch between multiple versions of R.
	r-switch () {

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
	rstudio-dev () {
		OWD="$(pwd)"
		cd ~/git/rstudio/src/xcode-build
		./desktop-mac/Debug/RStudio.app/Contents/MacOS/RStudio "$@" &
		cd $OWD
	}

	# Clear the launc services registry
	lsregister-clear () {
		lsregister -kill -r -domain local -domain user -domain system
	}

  clear-icon-cache () {
      sudo find /private/var/folders/ -name com.apple.dock.iconcache -exec rm {} \; 2> /dev/null
      sudo find /private/var/folders/ -name com.apple.iconservices -exec rm -rf {} \; 2> /dev/null
      sudo rm -rf /Library/Caches/com.apple.iconservices.store

      echo "Icon cache cleared. The icons will be refreshed next time you restart your system."
  }

fi

