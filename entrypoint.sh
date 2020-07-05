#!/bin/bash
set -e

export PATH="${JAVA_HOME}/bin:${PATH}"

if ! [ -d /data/save ]; then
	mkdir -p /data/save
	touch /data/save/.stfu
fi

if ! [ -f /data/PyLNP.user ]; then
	cat > /data/PyLNP.user <<EOF
{
  "tkgui_height": 800,
  "tkgui_width": 600
}
EOF
fi

cd /dwarfpack && exec ./game/startlnp.sh
