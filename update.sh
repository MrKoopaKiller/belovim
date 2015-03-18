#!/bin/bash
# beloVIM update for linux and macosx
# rabeloo at gmail dot com

echo "Getting pull on repository..."
git pull
git submodule update --init

echo "Updating plugins..."
git submodule foreach git pull origin master
