#!/bin/bash

docker pull mongo:latest
docker build -t asurov/post:1.0 ./post-py
docker build -t asurov/comment:1.0 ./comment
docker build -t asurov/ui:1.0 ./ui
