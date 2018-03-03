#!/bin/bash

docker kill $(docker ps -q)
docker run -d --network=reddit --network-alias=post_db --network-alias=comment_db -v reddit_db:/data/db  mongo:latest
docker run -d --network=reddit --network-alias=post asurov/post:1.0
docker run -d --network=reddit --network-alias=comment asurov/comment:1.0
docker run -d --network=reddit -p 9292:9292 asurov/ui:2.0
