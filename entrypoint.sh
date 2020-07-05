#!/bin/bash
set -e

export PATH="${JAVA_HOME}/bin:${PATH}"

mkdir -p /data/save
if ! [ -f /data/PyLNP.user ]; then
	cat > /data/PyLNP.user <<EOF
{
  "tkgui_height": 800,
  "tkgui_width": 600
}
EOF
fi

cd /dwarfpack && exec ./game/startlnp.sh
