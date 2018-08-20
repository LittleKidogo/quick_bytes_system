
FROM alpine:3.6

# we need bash and openssl for Phoenix
RUN apk upgrade --no-cache && \
    apk add --no-cache bash openssl

# set and expose port
EXPOSE 5002

ENV PORT=5002 \
    REPLACE_OS_VARS=true \
    SHELL=/bin/bash

ARG VERSION

ARG SEMVERSION=0.0.1


WORKDIR /app

ADD Dockerfile /app
#copy release artefact from last stage
ADD _build/prod/rel/qb_backend/releases/${SEMVERSION}/qb_backend.tar.gz /app

RUN chown -R root ./releases

USER root

ENTRYPOINT ["/app/bin/qb_backend"]

CMD ["foreground"]
