#!/bin/bash
set -e

echo -e "\n--------- INIT GIT REPO ---------"
echo -e "---------------------------------"
git init
git add -A
git commit -m 'Initial commit'

echo -e "\n--------- INSTALL HEX PACKAGES ---------"
echo -e "-----------------------------------------"
mix deps.get

{% if cookiecutter.database_setup == 'setup' %}
echo -e "\n--------- CREATE DB AND MIGRATE ---------"
echo -e "-----------------------------------------"
mix ecto.setup
{% elif cookiecutter.database_setup == 'migrate' %}
echo -e "\n--------- MIGRATE DB ---------"
echo -e "------------------------------"
mix ecto.migrate
{% endif %}

echo -e "\n--------- INSTALL ASSETS ---------"
echo -e "----------------------------------"
cd assets && yarn install
