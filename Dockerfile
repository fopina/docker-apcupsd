FROM alpine:3.19

RUN apk add --no-cache apcupsd curl bash

RUN curl -Lso /usr/local/bin/confgen \
         https://github.com/fopina/confgen/releases/download/v0.1.0/confgen_linux_$(uname -m | grep -q x86_64 && echo amd64 || echo arm)
RUN chmod a+x /usr/local/bin/confgen

COPY files/ /etc/apcupsd/
COPY docker-entrypoint.sh /entrypoint.sh

RUN chmod a+x /etc/apcupsd/mymail

ENV APCUPSD_MAIL="/etc/apcupsd/mymail"
ENV WEBHOOK_URL=""
ENV WEBHOOK_TEMPLATE='{{ env "EVENT" }} triggered on {{ env "UPSID" }} - {{ env "MSG" }}'
ENV WEBHOOK_EVENTS="changeme commfailure commok offbattery onbattery"
ENV EVENT_CHANGEME="battery needs changing NOW"
ENV EVENT_COMMFAILURE="communications with UPS lost"
ENV EVENT_COMMOK="communications with UPS restored"
ENV EVENT_OFFBATTERY="power has returned"
ENV EVENT_ONBATTERY="POWER FAILURE !!!"

ENTRYPOINT [ "./entrypoint.sh" ]

CMD [ "-b" ]
