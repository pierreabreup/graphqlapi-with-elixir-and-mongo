FROM elixir:1.7-alpine

RUN apk add --no-cache bash
RUN apk add --update \
  nodejs \
  build-base

EXPOSE 4000

WORKDIR /usr/src/app

RUN yes | mix local.hex

RUN yes | mix archive.install hex phx_new 1.4.0

COPY ./entrypoint.sh /etc/entrypoint.sh
RUN chmod +x /etc/entrypoint.sh
CMD ["/bin/sh"]
ENTRYPOINT ["/etc/entrypoint.sh"]
