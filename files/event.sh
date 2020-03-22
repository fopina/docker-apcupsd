#!/bin/bash

EVENT=$(basename ${0^^} '.SH')
UPSID="${1}"

msgvar="EVENT_$EVENT"

if [ -n "${!msgvar}" ]; then
    MSG="${!msgvar}"
else
    MSG=${EVENT}
fi

export EVENT UPSID MSG

/etc/apcupsd/mymail
