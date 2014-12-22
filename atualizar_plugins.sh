#!/bin/bash

echo "Atualizando plugins do vim"
git submodule foreach git pull origin master
