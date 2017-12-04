#!/bin/bash -el

# Installing deps
docker-compose run test mix deps.get

# Running tests
docker-compose run test