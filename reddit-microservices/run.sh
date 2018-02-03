#!/bin/bash

docker network create reddit
docker run -d --network=reddit --network-alias=post_db --network-alias=comment_db mongo:latest
docker run -d --network=reddit --network-alias=post asurov/post:1.0
docker run -d --network=reddit --network-alias=comment asurov/comment:1.0
docker run -d --network=reddit -p 9292:9292 asurov/ui:1.0

