#!/bin/bash

cd ~/gatus
git fetch -p
git merge origin/main

# Do the github token replace
TOKEN=$(<"~/.github_token")
sed -e "s/INSERT_TOKEN/$TOKEN/g" config.yaml.tmpl > config.yaml

if ! diff .git/refs/heads/main running_version; then
    echo "Restarting Gataus"
    sudo docker stop gatus
    sudo docker rm gatus
    sudo docker run -d -p 8080:8080 --mount type=bind,source="$(pwd)"/config.yaml,target=/config/config.yaml --name gatus twinproduction/gatus
fi

cp .git/refs/heads/main running_version