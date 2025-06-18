#!/bin/bash

cd ~/gatus
git fetch -p
git merge origin/main

if $(diff .git/refs/heads/main running_version) do
    echo "Restarting Gataus"
    sudo docker rm gatus
    sudo docker run -p 8080:8080 --mount type=bind,source="$(pwd)"/config.yaml,target=/config/config.yaml --name gatus twinproduction/gatus
done

cp .git/refs/heads/main running_version