#!/bin/env bash

DT=`date +"%Y-%m%d-%H%M%S"`

sudo docker run --name darkweb_$DT --cap-add=NET_ADMIN --cap-add=NET_BIND_SERVICE -p 8080:8080 -it $1
