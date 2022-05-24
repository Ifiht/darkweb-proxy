#!/bin/env bash

sudo docker run --name darkweb_test --cap-add=NET_ADMIN --cap-add=NET_BIND_SERVICE -it $1
