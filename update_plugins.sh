#!/bin/bash

echo "Updating plugins..."
git submodule foreach git pull origin master
