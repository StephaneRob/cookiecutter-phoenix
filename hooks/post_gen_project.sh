#!/bin/bash
set -e

echo -e "\n--------- INIT GIT REPO ---------"
git init
git add -A
git commit -m 'Initial commit'

echo -e "\n--------- INSTALL HEX PACKAGES ---------"
mix deps.get

echo -e "\n--------- CREATE DB AND MIGRATE ---------"
mix ecto.setup

echo -e "\n--------- INSTALL ASSETS ---------"
cd assets && npm install
