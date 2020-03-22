#!/bin/bash

for event in ${WEBHOOK_EVENTS}; do
    ln -sf /etc/apcupsd/event.sh /etc/apcupsd/${event,,}
done

echo ${WEBHOOK_TEMPLATE} > /etc/apcupsd/webhook.tmpl

if [ "$1" == "sh" ]; then
    exec /bin/bash
fi

if [ "$1" == "test-webhook" ]; then
    if [ -z "$2" ]; then
        echo "no event specified, choose one from:"
        echo " - ${WEBHOOK_EVENTS}"
        exit 2
    fi

    event=${2,,}

    if [ -f /etc/apcupsd/${event} -a -x /etc/apcupsd/${event} ]; then
        exec /etc/apcupsd/${event} fakeUPS
    fi

    echo "no script found for event: ${event}"
    exit 2
fi

exec apcupsd "$@"
