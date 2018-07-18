#!/usr/bin/env bash

docker-shell () {

	if [ "$#" -eq 0 ]; then
		echo "Usage: docker-shell [image]"
		return 0
	fi

	# get the image name
	local IMAGE
	IMAGE="${1-ubuntu}"

	# use custom entrypoint as needed
	case "${IMAGE}" in
	alpine*) ENTRYPOINT=(/bin/sh) ;;
	*)       ENTRYPOINT=(/usr/bin/env bash) ;;
	esac

	# get the container name
	local CONTAINER
	CONTAINER="$(printf "%s" "${IMAGE}" | tr -c '[:alnum:]_.' '-')-container"

	# see if there's a container already available; if not, create it
	if ! docker container inspect "${CONTAINER}" &> /dev/null; then
		docker create --interactive --tty --name "${CONTAINER}" "${IMAGE}" "${ENTRYPOINT[@]}" &> /dev/null
	fi

	# start and attach to the container
	docker start --attach --interactive "${CONTAINER}"
}

rocker-shell () {
	docker-shell rocker/tidyverse
}
