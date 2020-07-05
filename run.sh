#!/bin/sh

if ! [ -f seccomp.json ]; then
	curl -L -o seccomp.json 'https://raw.githubusercontent.com/moby/moby/master/profiles/seccomp/default.json'
	patch -p0 < seccomp.json.diff
fi

if [ "$(uname -s)" = "Darwin" ]; then
	docker run --rm \
		--cap-add CAP_SYS_PTRACE --security-opt seccomp=$(realpath ./seccomp.json) \
		--name dwf \
		-e DISPLAY=host.docker.internal:0 \
		-v $(realpath ./data):/data \
		-ti dwarfpack
fi
