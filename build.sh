#!/bin/env bash

DT=`date +"%Y-%m%d-%H%M%S"`

sudo docker build -t ifiht/darkweb-proxy:dev-$DT .
