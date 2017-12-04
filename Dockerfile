FROM elixir:1.5.2-alpine

RUN mix local.hex --force
RUN mix archive.install --force https://github.com/phoenixframework/archives/raw/master/phx_new.ez

WORKDIR /app