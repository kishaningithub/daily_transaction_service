#!/bin/bash -el

docker-compose run web mix ecto.create
docker-compose run web mix ecto.migrate