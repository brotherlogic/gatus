#!/bin/bash

cd ~/gatus
git fetch -p
git merge origin/main

if $(diff .git/refs/heads/main running_version); do
    echo "Restarting Gataus"
done

cp .git/refs/heads/main running_version