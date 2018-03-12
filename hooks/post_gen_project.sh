#!/bin/bash
set -e

echo -e "\n--------- INIT GIT REPO ---------"
git init
git add -A
git commit -m 'Initial commit'

echo -e "\n--------- INSTALL HEX PACKAGES ---------"
mix deps.get

{% if cookiecutter.database_setup == 'setup' %}
echo -e "\n--------- CREATE DB AND MIGRATE ---------"
mix ecto.setup
{% elif cookiecutter.database_setup == 'migrate' %}
echo -e "\n--------- MIGRATE DB ---------"
mix ecto.migrate
{% endif %}

echo -e "\n--------- INSTALL ASSETS ---------"
cd assets && yarn install
