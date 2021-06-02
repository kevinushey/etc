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
		
		docker image pull "${IMAGE}" || {
			echo "ERROR: docker image pull '${IMAGE}' failed [exit status $?]"
			return 1
		}

		docker create --interactive --tty --name "${CONTAINER}" "${IMAGE}" "${ENTRYPOINT[@]}" &> /dev/null || {
			echo "ERROR: docker create failed [exit status $?]"
			return 1
		}

	fi

	# start container
	docker start "${CONTAINER}" > /dev/null

	# attach bash
	docker exec --privileged --interactive --tty "${CONTAINER}" /bin/bash

}

rocker-shell () {
	docker-shell rocker/tidyverse
}
