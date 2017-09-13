#!/bin/sh
# Compile Minetest for AlpineLinux
rm -rf ./minetest-bin
docker build -t build-img -f Dockerfile.builder .
docker create --name build-container build-img
docker cp build-container:/tmp/minetest/ ./minetest-bin/
docker rm build-container

# Build Docker Image
docker build -t minetest .
