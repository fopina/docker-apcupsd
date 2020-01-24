FROM alpine:3.11

RUN apk add --no-cache apcupsd curl

COPY files/ /etc/apcupsd/
RUN chmod a+x /etc/apcupsd/mymail

ENTRYPOINT [ "apcupsd" ]

CMD [ "-b" ]
